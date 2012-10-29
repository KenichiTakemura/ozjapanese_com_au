class OzmainsController < OzController
  
  def index
    @feed = Hash.new
    @feed_cnt = Hash.new
    OzjapaneseStyle.headings.each do |heading|
      model_name = OzjapaneseStyle.heading_model_name(heading)
      date_feed = Array.new
      0.upto(1) { |d|
        date_feed[d] = TopFeedList.feed_for_date(model_name, d).count
        logger.debug("date_feed[#{d}]: #{date_feed[d]}")
      }
      @feed[heading.to_sym] = date_feed
      @feed_cnt[heading.to_sym] = TopFeedList.recent_feed(model_name, 2).count
      logger.debug("@feed[#{heading}]: #{@feed[heading.to_sym]}")
      logger.debug("@feed_cnt[#{heading}]: #{@feed_cnt[heading.to_sym]}")
    end
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
end
