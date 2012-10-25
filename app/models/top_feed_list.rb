class TopFeedList < ActiveRecord::Base

  TOP_FEED_LIMIT = 100
  TOP_FEED_SAVED_LIMIT = 150
  RECENT_DAYS = 9

  belongs_to :feeded_to, :polymorphic => true
  
  M2T = Common.new_orderd_hash
  M2T[:p_estate] = "estates"
  M2T[:p_business] = "businesses"
  M2T[:p_motor_vehicle] = "motor_vehicles"
  M2T[:p_accommodation] = "accommodations"
     
  # public scope
  scope :find_a_feed, lambda { |cate,id| where('feeded_to_type = ? AND feeded_to_id = ?', cate, id)}

  scope :with_image, lambda { |table| joins("left outer join #{table} on #{table}.id = top_feed_lists.feeded_to_id").where("#{table}.has_image = true") }

  scope :feed_order,  order("created_at DESC")
  scope :category_feed, lambda { |cate| where('feeded_to_type = ?', cate)}
  scope :date_feed, lambda { |date| where('created_at = ?', date)}
  scope :duration_feed, lambda { |x,y| where("created_at <=? and created_at > ?", (Common.days_ago(x)), (Common.days_ago(y)))}
  
  #scope :feed_with_image, lambda { |cate,limit| category_feed(cate).with_image(M2T[cate]).feed_order.limit(limit) }
  scope :except_ids, lambda { |ids| 
    if !ids.nil? && !ids.empty?  
      where('id not in (?)', ids)
    end
  }
  scope :feed_nomatter_image_except, lambda { |cate,ids,limit| category_feed(cate).except_ids(ids).feed_order.limit(limit) }
  scope :feed_nomatter_image, lambda { |cate,limit| category_feed(cate).feed_order.limit(limit) }
  
  scope :feed_for_date, lambda { |cate,day| category_feed(cate).duration_feed(day,day+1).feed_order }
  scope :recent_feed, lambda { |cate,day| category_feed(cate).duration_feed(day,RECENT_DAYS).feed_order }
  
  after_save :clean_oldest_feed
  
  def clean_oldest_feed
    category = self.feeded_to_type
    count = TopFeedList.category_feed(category).count
    logger.debug("Category: #{category} Feed Count: #{count}")
    return if (count <= TOP_FEED_SAVED_LIMIT)
    logger.debug("Clean oldest feeds")
    oldest_feed = oldest_feed(category)
    TopFeedList.destroy(oldest_feed)
    count = TopFeedList.category_feed(category).count
    logger.debug("Count: #{count}")
  end
  
  def to_s
    "feeded_to_id: #{feeded_to_id} feeded_to_type: #{feeded_to_type}"
  end

  protected

  private

  # private scope

  scope :category_oldest_feed, lambda { |cate| where('feeded_to_type = ?', cate).order("id ASC")}

  def oldest_feed(category)
    TopFeedList.category_oldest_feed(category).first
  end

end
