class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def debug?
    OzjapaneseComAu::Application.config.is_debug
  end
end
