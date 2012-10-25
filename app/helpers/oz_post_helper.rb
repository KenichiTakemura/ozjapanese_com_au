module OzPostHelper
  
  def post_write_new(heading, text)
    html = ""
    if current_flyer
      html += link_to_with_icon("#{t(:write_new)}",Ozlink.heading_link(heading,"write"),"btn","","icon-pencil","#{heading}_write_new")
    else
      html += %Q|<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">|
      html += %Q|<i class="icon-pencil icon-large"></i>#{t(:write_new)}&nbsp;<span class="caret"></span></a>|
      html += %Q|<ul class="dropdown-menu">|
      html += %Q|<li><div class="alert alert-info" style="z-index:10">#{t(:please_signin)}<br>#{signin(text)}</div></li></ul>|
    end
    html.html_safe
  end
  
  def build_board_list
    html = %Q|<table id="okboard_table" class="table table-striped table-hover">
        <thead class=""><tr><th style="width:0px;display:none"></th><th>#{t("post.id")}</th><th>|
    html += %Q|#{t("post.subject")}</th><th>#{t("post.postedOn")}</th><th>#{t("post.viewed")}</th><th>#{t("post.comment")}</th>
    <th>#{t("post.author")}</th></tr></thead>|
    html += %Q|<tbody class="">|
    if @board_lists.empty?
      html += %Q|<tr><td colspan="7">| + t("post.no_information")
      html += "</td><tr>"
    else
      html += build_body_list_body
    end
    html += "</tbody></table>"
    html.html_safe
  end

  def build_body_list_body
    html = ""
    @board_lists.each do |post|
      html += %Q|<tr class="#{cycle("odd", "even")}">|
      html += %Q|<td style="width:0px;display:none">#{post.id}</td>|
      if post.is_new?
        html += %Q|<td><span class="badge badge-success"><i class="icon-star icon-white"></i>#{post.id}</span></td>|
      else
        html += %Q|<td><span class="badge badge">#{post.id}</span></td>|
      end
      html += %Q|<td>#{link_to(post.subject,Ozlink.heading_link(@heading,"view",{:d => post.id}), :method => :post, :remote => true)}</td><td>#{post.postedDate}</td><td>#{post.views}</td><td>|
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
   html += %Q|<p id="carousel_view_#{heading}_#{post.id}">#{t("post.viewed")} #{post.views}</p>|
   html += "</div>"
   html.html_safe
  end
  
  def show_posts(posts, heading, id_suffix)
    html = ""
    if posts.present?
      html = %Q|<div id="listCarousel_#{id_suffix}" class="carousel slide" data-pause="hover" data-interval="30000"><div class="carousel-inner"><ul class="thumbnails">|
      posts.each_with_index do |post,i|
        html += %Q|<div class="item" id="#{heading}-#{post.id}">|
        html += %Q|<li class="span8 offset2">|
        html += show_a_post(post, heading)
        html += "</li></div>"
      end
      html += %Q|</ul><a class="carousel-control left" href="\#listCarousel_#{id_suffix}" data-slide="prev">&lsaquo;</a><a class="carousel-control right" href="\#listCarousel_#{id_suffix}" data-slide="next">&rsaquo;</a></div></div>|
      html += _script(%Q|$('\#listCarousel_#{id_suffix}').carousel('next');
      $('\#listCarousel_#{id_suffix}').bind('slid', function() {
        $.post('ozs/carousel_viewed',{p : $("\#listCarousel_#{id_suffix} .active").attr('id')});
      });|)
    end
    html.html_safe
  end
  
  def render_a_post(post)
    
  end
  
end