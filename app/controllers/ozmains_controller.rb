class OzmainsController < OzController
  
  def index
    @feed = Hash.new
    @feed_cnt = Hash.new
    OzjapaneseStyle.headings.each do |heading|
      model_name = OzjapaneseStyle.heading_model_name(heading)
      date_feed = Hash.new
      0.upto(1) { |d|
        date_key = Common.date_format(Common.days_ago(d))
        date_feed[date_key.to_sym] = TopFeedList.feed_for_date(model_name, Common.days_ago(d))
      }
      @feed[heading.to_sym] = date_feed
      @feed_cnt[heading.to_sym] = TopFeedList.recent_feed(model_name).count
      logger.debug("@feed[#{heading}]: #{@feed[heading.to_sym]}")
      logger.debug("@feed_cnt[#{heading}]: #{@feed_cnt[heading.to_sym]}")
    end
    @contact = Contact.new
    if current_flyer
      @contact.user_name = current_flyer.flyer_name
      @contact.email = current_flyer.email
    end
  end
  
  def about
    @contact = Contact.new
    @t = params[:t]
    if current_flyer
      @contact.user_name = current_flyer.flyer_name
      @contact.email = current_flyer.email
    end
  end
  
end
