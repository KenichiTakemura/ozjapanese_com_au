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
  
  # status
  # draft -> public -> hidden -> deleted
  attr_accessible :status
  
  # belongs_to
  belongs_to :posted_by, :polymorphic => true
  belongs_to :post_updated_by, :polymorphic => true

  # has_many
  has_many :comment, :as => :commented, :dependent => :destroy
  has_many :attachment, :as => :attached, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  # has_one
  has_one :content, :as => :contented, :dependent => :destroy
  has_one :top_feed_list, :as => :feeded_to, :dependent => :destroy

  # content
  accepts_nested_attributes_for :content
  attr_accessible :content, :content_attributes
  alias_method :content=, :content_attributes=

  attr_accessible :attached
  
  accepts_nested_attributes_for :attachment
  attr_accessible :attachment, :attachment_attributes
  alias_method :attachment=, :attachment_attributes=

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
 
  def set_default
    self.locale ||= PostDef::DEFAULT_LOCALE
    self.category ||= PostDef::DEFAULT_CATEGORY
    self.z_index ||= PostDef::DEFAULT_ZINDEX
    self.status ||= PostDef::POST_STATUS_PUBLIC
    self.mode ||= Role::R[:user_r] | Role::R[:user_w]
    self.write_at ||= Common.current_time.to_i
  end

  protected
  
  def topfeedable?
    false
  end

end
