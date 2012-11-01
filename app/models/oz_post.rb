class OzPost < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale
  attr_accessible :category
  attr_accessible :valid_until
  attr_accessible :views
  attr_accessible :z_index
  attr_accessible :write_at
  attr_accessible :mode
  attr_accessible :has_image
  attr_accessible :has_attachment
  attr_accessible :requested_by
  attr_accessible :subject
  attr_accessible :sns_feeded
  attr_accessible :sns_provider
  
  # status
  # draft -> public -> hidden -> deleted
  attr_accessible :status

  # belongs_to
  belongs_to :posted_by, :polymorphic => true
  belongs_to :post_updated_by, :polymorphic => true

  # has_many
  has_many :comment, :as => :commented, :class_name => 'Comment', :dependent => :destroy
  #has_many :attachment, :as => :attached, :class_name => 'Attachment', :dependent => :destroy
  #has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  # has_one
  has_one :content, :as => :contented, :dependent => :destroy
  has_one :top_feed_list, :as => :feeded_to, :dependent => :destroy

  # content
  accepts_nested_attributes_for :content
  attr_accessible :content, :content_attributes
  alias_method :content=, :content_attributes=

  attr_accessible :attached

  #accepts_nested_attributes_for :attachment
  #attr_accessible :attachment, :attachment_attributes
  #alias_method :attachment=, :attachment_attributes=

  # validator
  validates_presence_of :locale
  validates_presence_of :subject
  validates_presence_of :valid_until
  validates_presence_of :status
  validates_presence_of :write_at
  #
  def to_s
    "id: #{id} category: #{category} locale: #{locale} subject: #{subject} valid_until: #{valid_until} status #{status}"
  end

  after_initialize :set_default
  after_save :add_top_feed_list, :delete_top_feed_list

  # public functions
  def add_top_feed_list
    logger.debug("add_top_feed_list topfeedable: #{self.topfeedable?}")
    return unless topfeedable?
    logger.debug("category: #{self}")
    return if self.category == PostDef::ADMIN_POST_NOTICE
    feed = TopFeedList.find_a_feed(self.class.to_s, self.id).first
    logger.debug("Feed: #{feed}")
    if feed
      # Existing in feed
      logger.debug("Feed exists #{feed}")
      feed.destroy
    end
    top_feed = TopFeedList.new
    top_feed.created_at = self.created_at
    top_feed.update_attribute(:feeded_to, self)
    logger.debug("Feeded_to: #{top_feed.id}")
  end

  # Delete post from top_feed when deleted
  def delete_top_feed_list
    return unless topfeedable?
    if self.status != PostDef::POST_STATUS_PUBLIC
      logger.debug("delete_from_top_feed_list #{self}")
      feed = TopFeedList.find_a_feed(self.class.to_s, self.id).first
    feed.destroy if feed
    end
  end

  def set_default
    self.locale ||= PostDef::DEFAULT_LOCALE
    self.category ||= PostDef::DEFAULT_CATEGORY
    self.z_index ||= PostDef::DEFAULT_ZINDEX
    self.status ||= PostDef::POST_STATUS_PUBLIC
    self.mode ||= Role::R[:user_r] | Role::R[:user_w]
    self.write_at ||= Common.current_time.to_i
  end

  def set_user(user)
    update_attribute(:posted_by, user)
  #user.mypage.add_post
  end

  def author_name
    self.posted_by.flyer_name
  end

  def postedDate
    Common.date_format_ymdhm(created_at)
  end
  
  def is_new?
    logger.debug("is_new? #{self.created_at} #{Common.days_ago(TopFeedList::RECENT_DAYS)}")
    (self.created_at >= Common.days_ago(TopFeedList::RECENT_DAYS))
  end
  
  def viewed
    update_attribute(:views, views + 1)
  end

  
  ##
  # SCOPE
  ##
  scope :search_no_order, lambda { |limit| valid_post.limit(limit)}
  scope :search, lambda { |limit| search_no_order(limit).desc }
  scope :search_older_than, lambda { |limit,day| post_search_by_time(day,-1).search_no_order(limit).desc }
  scope :search_newer_than, lambda { |limit,day| post_search_by_time(-1,day).search_no_order(limit).desc }
  scope :search_before, lambda { |limit,post_id| post_before(post_id).search_no_order(limit).desc }
  scope :search_after, lambda { |limit,post_id| post_after(post_id).search_no_order(limit).desc }

  protected

  scope :asc, :order => 'id ASC'
  scope :desc, :order => 'id DESC'
  scope :raw_post, where("z_index = ?", 0)
  scope :is_valid, where("status = ?", PostDef::POST_STATUS_PUBLIC)
  scope :is_invalid, where("status = ? OR status = ?", PostDef::POST_STATUS_HIDDEN, PostDef::POST_STATUS_DRAFT)
  scope :expired, where("status = ?", PostDef::POST_STATUS_EXPIRED)
  scope :latest, is_valid.raw_post.desc
  scope :valid_post, is_valid.raw_post
  scope :priority_post, is_valid.where("z_index != ?", 0).desc

  scope :post_after, lambda { |post_id| 
    if post_id.present? 
      where('id > ?', post_id)
    end
  }
  scope :post_before, lambda { |post_id| 
    if post_id.present? 
      where('id < ?', post_id)
    end
  }



  scope :post_search_by_time, lambda { |x,y| 
    if x.to_i < 0
      where("created_at > ?", (Common.days_ago(y)))
    elsif y.to_i > 0
      where("created_at <=? and created_at > ?", (Common.days_ago(x)), (Common.days_ago(y)))
    elsif x.to_i > 0
      where("created_at <=?", (Common.days_ago(x)))
    end
  }
  

  def topfeedable?
    false
  end

end
