class TermsController < OzController

  def index
    @token = params[:token]
    logger.info("token: #{params[:token]}")
    raise "Bad Request" if !@token.present?
    valid = session["ozjapanese.terms.token"].eql?(@token)
    raise "Bad Request" if !valid
    @term = Term.new
  end
  
  def create
    token = params[:token]
    logger.info("token: #{params[:token]}")
    raise "Bad Request" if !token.present?
    @flyer = Flyer.find_by_agree_token(token)
    raise "Bad Flyer" if !@flyer.present?
    @flyer.agree
    logger.info("term create remember_me: #{session[:remember_me]}")
    if session[:remember_me]
      @flyer.remember_me = true
    end
    ContactMailer.send_signup_to_admin(@flyer).deliver
    ContactMailer.send_signup_to_flyer(@flyer).deliver
    sign_in_and_redirect @flyer, :event => :authentication
  end
  
end
