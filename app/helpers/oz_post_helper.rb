module OzPostHelper
  
  def post_write_new(heading)
    html = ""
    if current_flyer
      html += link_to_with_icon("#{t(:write_new)}",Ozlink.heading_link(heading,"write"),"btn","","icon-pencil","#{heading}_write_new")
    else
      html += %Q|<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">|
      html += %Q|<i class="icon-pencil icon-large"></i>#{t(:write_new)}&nbsp;<span class="caret"></span></a>|
      html += %Q|<ul class="dropdown-menu">|
      html += %Q|<li><div class="alert alert-info">#{t(:please_signin)}<br>#{signin}</div></li></ul>|
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
        html += %Q|<td><span class="badge badge-success">#{post.id}</span></td>|
      else
        html += %Q|<td><span class="badge badge">#{post.id}</span></td>|
      end
      html += %Q|<td>#{post.subject}</td><td>#{post.postedDate}</td><td>#{post.views}</td><td>|
      html += %Q|<i class="icon-comment"></i>#{post.comment.size}</td>|
      html += %Q|<td>| + link_to(post.author_name,post.posted_by.flyer_url) + %Q|</td>|
    end
    html.html_safe
  end
end