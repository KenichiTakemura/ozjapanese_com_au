class Contact < ActiveRecord::Base
  # belongs_to
  belongs_to :contacted_by, :polymorphic => true

  attr_accessible :email, :user_name, :phone, :contact_type, :body
  
  validates_presence_of :email
  validates_presence_of :user_name
  validates_presence_of :phone
  validates_presence_of :contact_type
  validates_presence_of :body
  validates_format_of :email, :with => PostDef::EMAIL_REGEXP, :if => Proc.new { |email| email.present? }
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => Proc.new { |phone| phone.present? }

  def category_list()
    list = Array.new
    list.push([I18n.t("contact.banner"),PostDef::CONTACT_BANNER])
    list.push([I18n.t("contact.general"),PostDef::CONTACT_GENERAL])
    list.push([I18n.t("contact.feedback"),PostDef::CONTACT_FEEDBACK])
    list.push([I18n.t("contact.request"),PostDef::CONTACT_REQUEST])
    list.push([I18n.t("contact.issue"),PostDef::CONTACT_ISSUE])
    list.push([I18n.t("contact.exit"),PostDef::CONTACT_EXIT])
    list.push([I18n.t("contact.recomment_pro"),PostDef::CONTACT_RECOMMEND_PRO])
    
    list
  end
  
  def set_user(user)
    update_attribute(:contacted_by, user)
  end
  
end