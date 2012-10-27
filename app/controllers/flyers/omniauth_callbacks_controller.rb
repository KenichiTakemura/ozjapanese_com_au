class Flyers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = Flyer.find_for_facebook_oauth(request.env["omniauth.auth"], current_flyer)

    if @user.present? && @user.persisted?
      if @user.agreed_on
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success.please_agree", :kind => "Facebook"
        token = Devise.friendly_token
        session["ozjapanese.terms.token"] = token
        @user.update_attribute(:agree_token, token)
        redirect_to terms_path(:token => token)
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_flyer_registration_url
      redirect_to root_path
    end
  end
  
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = Flyer.find_for_google_oauth2(request.env["omniauth.auth"], current_flyer)

      if @user.present? && @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        #redirect_to new_flyer_registration_url
        redirect_to root_path
      end
  end
  
  # Override
  def failure
    logger.error("OmniauthCallbacksController failure_message: #{failure_message}")
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end
  
  def after_omniauth_failure_path_for(scope)
    logger.warn("after_omniauth_failure_path_for #{scope}")
    root_path
  end
end