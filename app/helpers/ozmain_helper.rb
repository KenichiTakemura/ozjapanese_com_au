module OzmainHelper
 
  def signin(text)
    #html = %Q|#{t(text)}#{link_to(facebook,flyer_omniauth_authorize_path(:facebook),:class => "")} #{link_to(google,flyer_omniauth_authorize_path(:google_oauth2),:class => "")}|
    html = %Q|<a href="\#ozj_signin_modal", role="button", class="btn" data-toggle="modal"><i class="icon-signal"></i>#{t(:lets_signin)} #{facebook} #{google}</a>|
    html.html_safe
  end
  
  def show_flyer(flyer=nil)
    return "" if flyer.nil? && !current_flyer
    if flyer.nil?
      flyer = current_flyer
    end
    html = ""
    if flyer.google_flyer?
      if flyer.flyer_url.present?
        html = link_to(flyer.flyer_name,flyer.flyer_url)
      else
        html = flyer.flyer_name
      end
    elsif flyer.facebook_flyer?
      if flyer.flyer_url.present?
        html = "#{link_to(flyer.flyer_name,flyer.flyer_url)}"
      else
        html = flyer.flyer_name
      end
      if flyer.flyer_image.present?
        html += "#{image_tag(flyer.flyer_image, :alt => "")}"
      end
    else
      #local
      html = flyer.flyer_name
    end
    html.html_safe
  end
  
  def show_flyer_name
    return current_flyer.flyer_name
  end
  
end
