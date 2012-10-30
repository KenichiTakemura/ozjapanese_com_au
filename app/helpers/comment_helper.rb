module CommentHelper
  
  def show_comment_thread(post, heading)
   html = %Q|<div class="row-fluid">|
   if post.comment.size > PostDef::NUMBER_OF_COMMENT
     html += render "comments/view_all_comments", :heading => heading, :post => post
   end
   html += show_comments(@comments)
   html += "</div>"
   html.html_safe
  end
  
  def show_comments(comments)
    html = ""
    comments.each do |comment|
      html += %Q|<span class="badge">#{t("post.comment")}\##{comment.number}</span>|
      html += %Q|<blockquote>#{simple_format(comment.body, :class => 'comment-text')}|
      html += %Q|<small>#{comment.postedDate}</small>|
      html += %Q|<small>#{show_flyer(comment.commented_by)}</small></blockquote>|
    end
    html.html_safe
  end
  
end