class SessionsController < ApplicationController
  
  def signin
    @provider = params[:provider]
    raise "Bad Request" if !@provider.present?
    remember_me = params[:remember_me]
    session[:remember_me] = true if remember_me.present?
    session["user_return_to"] = request.original_url
    logger.info("signin starts. provider: #{@provider} remember_me: #{session[:remember_me]} return_to: #{session["user_return_to"]}")
  end
  
end
