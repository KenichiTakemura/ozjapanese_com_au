class Contact < ActiveRecord::Base
  
  ADMIN_EMAIL = "ktakemur@redhat.com"
  #ADMIN_EMAIL = "kenichi_takemura1976@yahoo.com"
  
  def self.admin_email
    ADMIN_EMAIL
  end

  CONTACT_lIST = [
    "contact.banner",
    "contact.general",
    "contact.feedback",
    "contact.request",
    "contact.issue",
    "contact.exit",
    "contact.recomment_pro",
    "contact.never_agree"
    ]

  # belongs_to
  belongs_to :contacted_by, :polymorphic => true

  attr_accessible :email, :user_name, :phone, :contact_type, :body
  
  validates_presence_of :email
  validates_presence_of :user_name
  validates_presence_of :contact_type
  validates_presence_of :body
  validates_format_of :email, :with => PostDef::EMAIL_REGEXP, :if => Proc.new { |email| email.present? }
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => :validate_phone

  def validate_phone
    Rails.logger.debug("Phone Validation on #{phone}")
    phone.present?
  end

  def category_list()
    list = Array.new
    CONTACT_lIST.each_with_index do |c,i|
      list.push([I18n.t(c), i])
    end
    list
  end
  
  def self.type?(letter)
    CONTACT_lIST.index letter
  end
  
  def title(type)
    I18n.t(CONTACT_lIST[type])
  end
  
  def set_user(user)
    update_attribute(:contacted_by, user)
  end
  
end