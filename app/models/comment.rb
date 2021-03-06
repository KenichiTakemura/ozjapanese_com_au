class Comment < ActiveRecord::Base
  attr_accessible :body, :status, :locale, :likes, :dislikes, :abuse

  belongs_to :commented_by, :polymorphic => true

  belongs_to :commented, :polymorphic => true
  scope :desc, :order => 'id DESC'
  scope :is_valid, where("status = ?", PostDef::POST_STATUS_PUBLIC)
  scope :recent_feed, is_valid.desc.limit(PostDef::NUMBER_OF_TOP_COMMENT_FEED)
  
  def size
    is_valid.size
  end
  
  after_initialize :set_default
  
  def set_default
    self.locale ||= PostDef::DEFAULT_LOCALE
    self.status ||= PostDef::POST_STATUS_PUBLIC
  end
    
  # validator
  validates_presence_of :body
  validates_length_of :body, :maximum => PostDef::MAX_POST_COMMENT_LENGTH

  # Add a comment to a post
  def subscribe_to(post, user)
    comment_size = post.comment.size
    number = comment_size > 0 ? comment_size + 1 : 1
    update_attribute(:number, number)
    self.update_attribute(:commented_by, user)
    self.update_attribute(:commented, post)
  end

  def postedDate
    Common.date_format_ymdhm(created_at)
  end
  
  scope :desc, :order => 'id DESC'
  scope :search_by_post, lambda { |post| where("commented_id = ?", post)}
  
  scope :comment_for, lambda { |post| search_by_post(post).desc }
  
  # ---
  
  def like
    update_attribute(:likes, likes + 1)
  end
  
  def dislike
    update_attribute(:dislikes, dislikes + 1)
  end
    
  def report_abuse
    update_attribute(:abuse, abuse + 1)
  end
  
  def hide?
    abuse >= PostDef::POST_ABUSE_LIMIT
  end
  
end
