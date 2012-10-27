class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def debug?
    OzjapaneseComAu::Application.config.is_debug
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
  
end
