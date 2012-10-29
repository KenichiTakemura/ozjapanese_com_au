class OzmainsController < OzController
  
  def index
    @contact = Contact.new
    if current_flyer
      @contact.user_name = current_flyer.flyer_name
      @contact.email = current_flyer.email
    end
    breadcrumb :root
  end
  
  def uzatt
    session[:uzatt] = true
  end
  
  def about
    @contact = Contact.new
    @t = params[:t]
    contact_type = params[:contact_type]
    if contact_type.present? && Contact::CONTACT_lIST[contact_type.to_i]
      @contact.contact_type = contact_type 
    end
    if current_flyer
      @contact.user_name = current_flyer.flyer_name
      @contact.email = current_flyer.email
    end
  end
  
  # Ajax
  def recent_top_feed
    @recent_top_feed = TopFeedList.recent_top_feed(5)
  end
  
  # Ajax
  def recent_comment_feed
    @recent_comment_feed = Comment.recent_feed
  end
  
end
