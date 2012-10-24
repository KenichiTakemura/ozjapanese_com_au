module OzmainHelper

  def link_to_with_icon(t,h,c,s,i,d)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def show_notice(message=nil)
    html = ""
    if notice.present?
      html = %Q|<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{notice}</h4></div>|
    elsif message.present?
      html = %Q|<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{message}</h4></div>|
    end
    html.html_safe
  end
  
  def show_alert(message=nil)
    html = ""
    if alert.present?
      html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{alert}</h4></div>|
    elsif message.present?
      html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{message}</h4></div>|
    end
    html.html_safe
  end
  
  def _script_document_ready(script)
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {#{script}});</script>|
    html.html_safe
  end

  def _script(script)
    %Q|<script type="text/javascript" charset="utf-8">#{script}</script>|.html_safe
  end
  
  def signin
    html = %Q|#{t(:signin_with)}#{link_to(image_tag("f_logo.png", :class => "image-resize30_30"),flyer_omniauth_authorize_path(:facebook))} #{link_to(image_tag("google_logo_3D_online_small.png", :class => ""),flyer_omniauth_authorize_path(:google_oauth2))}|
    html.html_safe
  end
  
  def show_flyer
    return "" if !current_flyer
    html = ""
    if current_flyer.provider.eql?("google_oauth2")
      html = link_to(current_flyer.flyer_name,current_flyer.flyer_url)
    elsif current_flyer.provider.eql?("facebook")
      html = link_to(current_flyer.flyer_name,current_flyer.flyer_url)
      html += image_tag(current_flyer.flyer_image)
    end
    html
  end
  
  def show_flyer_name
    return current_flyer.flyer_name
  end
end
