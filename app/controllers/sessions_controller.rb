class SessionsController < ApplicationController
  
  def signin
    @provider = params[:provider]
    raise "Bad Request" if !@provider.present?
    remember_me = params[:remember_me]
    session[:remember_me] = true if remember_me.present?
  end
  
end
