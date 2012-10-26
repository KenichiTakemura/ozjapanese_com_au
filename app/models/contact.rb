class Contact < ActiveRecord::Base
  
  CONTACT_BANNER = 1
  CONTACT_GENERAL = 2
  CONTACT_FEEDBACK = 3
  CONTACT_ISSUE = 4
  CONTACT_EXIT = 5
  CONTACT_REQUEST = 6
  CONTACT_RECOMMEND_PRO = 7
  
  ADMIN_EMAIL = "ktakemur@redhat.com"
  
  def admin_email
    ADMIN_EMAIL
  end

  CONTACT_lIST = [
    "contact.banner",
    "contact.general",
    "contact.feedback",
    "contact.request",
    "contact.issue",
    "contact.exit",
    "contact.recomment_pro"
    ]

  # belongs_to
  belongs_to :contacted_by, :polymorphic => true

  attr_accessible :email, :user_name, :phone, :contact_type, :body
  
  validates_presence_of :email
  validates_presence_of :user_name
  validates_presence_of :contact_type
  validates_presence_of :body
  validates_format_of :email, :with => PostDef::EMAIL_REGEXP, :if => Proc.new { |email| email.present? }
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => Proc.new { |phone| phone.present? }

  def category_list()
    list = Array.new
    CONTACT_lIST.each_with_index do |c,i|
      list.push([I18n.t(c), i])
    end
    list
  end
  
  def title(type)
    I18n.t(CONTACT_lIST[type])
  end
  
  def set_user(user)
    update_attribute(:contacted_by, user)
  end
  
end