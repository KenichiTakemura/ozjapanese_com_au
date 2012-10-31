module SnsHelper
  
  def facebook
    image_tag("f_logo.png", :class => "image-resize30_30")
  end
  
  def google
    image_tag("google_logo_3D_online_small.png", :class => "")
  end
  
  def post_fb_feed(heading, post)
    html = ""
    token = Common.uniqe_token
    if current_flyer && current_flyer.facebook_flyer? 
      html = %Q|<p>#{facebook}&nbsp;<a href="\#" onclick='postToFeed_#{token}(); return false;'>#{t("post.post_fb_feed")}</a></p>|
      html += %Q|<p id='msg_#{token}'></p>|
      html += _script(%Q|
        function postToFeed_#{token}() {
          var obj = {
            method: 'feed',
            link: '#{root_url}#{Ozlink.heading_link(heading,"link_view", {:d => post.id})}',
            source: '#{root_url}',
            name: '#{post.subject}',
            caption: '#{t("facebook.caption")}',
            description: '#{t("facebook.desc")}',
            picture: '#{Ozlink.logo}'
          };
          #{fb_callback_handler(token)}
          FB.ui(obj, callback);
        }
      |)
    end
    html.html_safe
  end
  
  def fb_callback_handler(token)
     html = <<-HTML
        function callback(response) {
            if(response['post_id'] != null) {
              document.getElementById('msg_#{token}').innerHTML = '#{escape_javascript(show_notice(t("facebook.shouted")))}';
            } else {
              document.getElementById('msg_#{token}').innerHTML = '#{escape_javascript(show_notice(t("facebook.failed")))}';     
            }
          }
     HTML
     html.html_safe
  end
  
  def fb_shout
    html = ""
    token = Common.uniqe_token
    if current_flyer && current_flyer.facebook_flyer? 
      html = %Q|<p>#{facebook}&nbsp;<a href="\#" onclick='facebook_shout_#{token}(); return false;'>#{t("facebook.shout")}</a></p>|
      html += %Q|<p id='msg_#{token}'></p>|
      html += _script(%Q|
        function facebook_shout_#{token}() {
          // calling the API ...
          var obj = {
            method: 'feed',
            link: '#{root_url}',
            source: '#{root_url}',
            name: '#{t("facebook.wall")}',
            caption: '#{t("facebook.caption")}',
            description: '#{t("facebook.desc")}',
            picture: '#{Ozlink.logo}'
          };
          #{fb_callback_handler(token)}
          FB.ui(obj, callback);
        }
      |)
    end
    html.html_safe
  end  
  
end
