module CommentHelper
  
  def show_comment_thread(post, heading)
   html = %Q|<div class="row-fluid">|
   post.comment.reverse_each do |comment|
    html += %Q|<span class="badge">#{t("post.comment")}\##{comment.number}</span>|
    html += %Q|<blockquote><p>#{simple_format(comment.body)}</p>|
    html += %Q|<small>#{show_flyer(comment.commented_by)}</small></blockquote>|
   end
   html += "</div>"
   html.html_safe
  end
  
end