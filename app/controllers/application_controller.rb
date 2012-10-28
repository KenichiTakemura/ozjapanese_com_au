class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :hit
  
  def debug?
    OzjapaneseComAu::Application.config.is_debug
  end
  
  def after_sign_in_path_for(resource)
    logger.info("after_sign_in_path_for request.referer: #{request.referer}")
    if (request.referer =~ /terms/)
      root_path
    else
      request.env['omniauth.origin'] || request.referer || stored_location_for(resource) || root_path
    end
  end
  
  def hit
    key = Common.today
    Rails.logger.debug("hit from : #{request.remote_ip}")
    return if request.remote_ip.eql?(OzjapaneseComAu::Application.config.my_host)
    unless session[key.to_sym]
      daily_hit = Rails.cache.read(:daily_hit).presence || 0
      daily_member_hit = Rails.cache.read(:daily_member_hit).presence || 0
      Rails.cache.write(:daily_hit, daily_hit + 1);
      if current_flyer
        Rails.cache.write(:daily_member_hit, daily_member_hit + 1);
      end
      session[key.to_sym] = true
      Rails.logger.debug("daily_hit: #{Rails.cache.read(:daily_hit)}")
      Rails.logger.debug("daily_member_hit: #{Rails.cache.read(:daily_member_hit)}")
    end
  end
  
  protected
  
  def record_not_found
    render :file => File.join("#{Rails.root}", 'public', '404.html'), :layout => false, :status => 404
  end

  
end
