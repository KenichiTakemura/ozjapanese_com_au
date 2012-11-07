module OzmainHelper
 
  def signin(text)
    #html = %Q|#{t(text)}#{link_to(facebook,flyer_omniauth_authorize_path(:facebook),:class => "")} #{link_to(google,flyer_omniauth_authorize_path(:google_oauth2),:class => "")}|
    html = %Q|<a href="\#ozj_signin_modal", role="button", class="btn" data-toggle="modal"><i class="icon-signal"></i>#{t("auth.signin")} #{facebook} #{google}</a>|
    html.html_safe
  end
  
  def show_flyer_header(flyer=nil)
    return "" if flyer.nil? && !current_flyer
    if flyer.nil?
      flyer = current_flyer
    end
    html = %Q|<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">|
    if !flyer.flyer_image.present?
      html += %Q|<i class="icon-user"></i>#{flyer.flyer_name}|
    else
      html += flyer.flyer_name
    end
    html += %Q|<span class="caret"></span></a><ul class="dropdown-menu">|
    if flyer.flyer_url.present?
      html += %Q|<li><a href="#{flyer.flyer_url}">#{t("auth.view_profile")}</a><li>|
    end
    html += %Q|<li><a href="#{destroy_flyer_session_path}"><i class="icon-leaf icon-white"></i>#{t("auth.signout")}</a></li>|
    html += "</ul>&nbsp;"
    if flyer.flyer_image.present?
      html += image_tag(flyer.flyer_image, :alt => "")
    end
    html.html_safe
  end

  def show_flyer(flyer=nil)
    html = ""
    return "" if flyer.nil? && !current_flyer
    if flyer.nil?
      flyer = current_flyer
    end
    if flyer.flyer_url.present?
      html += %Q|<a href="#{flyer.flyer_url}">#{flyer.flyer_name}</a>|
    else
      html += flyer.flyer_name
    end
    if flyer.flyer_image.present?
      html += image_tag(flyer.flyer_image, :alt => "")
    end
    html.html_safe
  end
  
  def show_flyer_name
    return current_flyer.flyer_name
  end
  
end
