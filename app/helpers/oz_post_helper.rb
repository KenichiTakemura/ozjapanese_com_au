module OzPostHelper
  
  def post_write_new(heading, text)
    html = ""
    if current_flyer
      html += link_to_with_icon("#{t("post.write_new")}",Ozlink.heading_link(heading,"write"),"btn btn-link","","icon-pencil","#{heading}_write_new")
    else
      html += %Q|<a class="btn btn-link dropdown-toggle" data-toggle="dropdown" href="#">|
      html += %Q|<i class="icon-pencil icon-large"></i>#{t("post.write_new")}&nbsp;<span class="caret"></span></a>|
      html += %Q|<ul class="dropdown-menu">|
      html += %Q|<li><div class="alert alert-info" style="z-index:10">#{t("please_signin")}<br>#{signin(text)}</div></li></ul>|
    end
    html.html_safe
  end
  
  def post_comment_new(heading, post, text)
    html = ""
    if current_flyer
      @post_for_comment = post
      html += render :partial => "comments/comment_form"
    else
      html += %Q|<div class="btn-group dropup"><a class="btn dropdown-toggle" data-toggle="dropdown" href="#">|
      html += %Q|<i class="icon-comment icon-large"></i>#{t("post.comment_new")}&nbsp;<span class="caret"></span></a>|
      html += %Q|<ul class="dropdown-menu">|
      html += %Q|<li><div class="alert alert-info" style="z-index:10">#{t("please_signin")}<br>#{signin(text)}</div></li></ul></div>|
    end
    html.html_safe
  end 
  
  def build_board_list(token)
    html = %Q|<table id="okboard_table" class="table table-striped table-hover">
        <thead class=""><tr><th style="width:0px;display:none"></th><th>#{t("post.id")}</th><th>|
    html += %Q|#{t("post.subject")}</th><th>#{t("post.postedOn")}</th><th>#{t("post.viewed")}</th><th>#{t("post.comment")}</th>
    <th>#{t("post.author")}</th></tr></thead>|
    html += %Q|<tbody class="">|
    if @posts.empty?
      html += %Q|<tr><td colspan="7">| + t("post.no_information")
      html += "</td><tr>"
    else
      html += build_body_list_body(token)
    end
    html += "</tbody></table>"
    html += %Q|<div class="btn-toolbar"><div class="btn-group">|
    if @posts.present?
      html += %Q|#{link_to_with_icon(t("post.more"),"\#","btn","","icon-shopping-cart","")}|    
    end
    html += "</div></div>"
    html.html_safe
  end

  def build_body_list_body(token)
    html = ""
    @posts.each do |post|
      html += %Q|<tr class="#{cycle("odd", "even")} select">|
      html += %Q|<td style="width:0px;display:none">#{post.id}</td>|
      if post.is_new?
        html += %Q|<td><span class="badge badge-success"><i class="icon-star icon-white"></i>#{post.id}</span></td>|
      else
        html += %Q|<td><span class="badge badge">#{post.id}</span></td>|
      end
      html += %Q|<td>#{link_to(post.subject,Ozlink.heading_link(@heading,"viewed",{:d => post.id}), :method => :post, :remote => true, :onclick => "view_post_#{token}()")}</td><td>#{post.postedDate}</td><td>#{post.views}</td><td>|
      html += %Q|<i class="icon-comment"></i>#{post.comment.size}</td>|
      html += %Q|<td>| + link_to(post.author_name,post.posted_by.flyer_url) + %Q|</td>|
    end
    html.html_safe
  end
  
  def show_a_post(post, heading)
   html = %Q|<div class="thumbnail">|
   if post.is_new?
   html += %Q|<span class="badge badge-success">#{post.id}</span>|
   else
   html += %Q|<span class="badge">#{post.id}</span>|
   end
   html += simple_format(post.content.body)
   html += %Q|<h3>#{post.subject}</h3>|
   html += "<p>#{t("post.postedOn")} #{post.postedDate}</p>"
   html += "<p>#{t("post.author")} #{show_flyer(post.posted_by)}</p>"
   html += post_fb_feed(heading, post)
   html += %Q|<p id="carousel_view_#{heading}_#{post.id}">#{t("post.viewed")} #{post.views}</p>|
   html += %Q|<p><i class="icon-comment"></i> #{post.comment.size}</p>|
   html += %Q|<div class="row-fluid">#{post_comment_new(heading,post,:signin_with_following)}<div id="post_comment_area_#{post.id}"></div></div>|
   html += "</div>"
   html.html_safe
  end
  
  def show_posts(posts, heading, id_suffix)
    html = ""
    if posts.present?
      html = %Q|<div id="listCarousel_#{id_suffix}" class="carousel slide"><div class="carousel-inner"><ul class="thumbnails">|
      posts.each_with_index do |post,i|
        html += %Q|<div class="item" id="#{heading}-#{post.id}">|
        html += %Q|<li class="span8 offset2">|
        html += show_a_post(post, heading)
        html += "</li></div>"
      end
      html += %Q|</ul><a class="carousel-control left" href="\#listCarousel_#{id_suffix}" data-slide="prev">&lsaquo;</a><a class="carousel-control right" href="\#listCarousel_#{id_suffix}" data-slide="next">&rsaquo;</a></div></div>|
      html += _script(%Q|
      $('\#listCarousel_#{id_suffix}').carousel({pause:"hover",interval:30000});
      $('\#listCarousel_#{id_suffix}').carousel('next');
      $('\#listCarousel_#{id_suffix}').bind('slid', function() {
        $.post('ozs/carousel_viewed',{p : $("\#listCarousel_#{id_suffix} .active").attr('id')});
      });|)
    end
    html.html_safe
  end
  
  def post_fb_feed(heading, post)
    html = ""
    if current_flyer && current_flyer.facebook_flyer? 
      html = %Q|<p>#{facebook}&nbsp;<a href="\#" onclick='postToFeed(); return false;'>#{t("post.post_fb_feed")}</a></p>|
      html += %Q|<p id='msg'></p>|
      html += _script(%Q|
        function postToFeed() {
          // calling the API ...
          var obj = {
            method: 'feed',
            link: '#{root_url} + #{Ozlink.heading_link(heading,"view", {:d => post.id})}',
            source: '#{root_url}',
            name: '#{post.subject}',
          };
  
          function callback(response) {
            document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
          }
  
          FB.ui(obj, callback);
        }
      |)
    end
    html.html_safe
  end  
end