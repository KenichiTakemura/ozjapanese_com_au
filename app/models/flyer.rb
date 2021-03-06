class Flyer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :registerable, :trackable, :omniauthable
  # Setup accessible (or protected) attributes for your model
  
  # Association
  has_many :oz_employment, :as => :posted_by, :class_name => 'OzEmployment', :dependent => :destroy
  has_many :oz_employer, :as => :posted_by, :class_name => 'OzEmployer', :dependent => :destroy
  has_many :oz_sell_good, :as => :posted_by, :class_name => 'OzSellGood', :dependent => :destroy
  has_many :oz_buy_good, :as => :posted_by, :class_name => 'OzBuyGood', :dependent => :destroy
  has_many :oz_estate_share_rent, :as => :posted_by, :class_name => 'OzEstateShareRent', :dependent => :destroy
  has_many :oz_info_event, :as => :posted_by, :class_name => 'OzInfoEvent', :dependent => :destroy
  has_many :oz_people_pro, :as => :posted_by, :class_name => 'OzPeoplePro', :dependent => :destroy
  has_many :oz_info_living_smart, :as => :posted_by, :class_name => 'OzInfoLivingSmart', :dependent => :destroy
  has_many :oz_info_living_qna_good, :as => :posted_by, :class_name => 'OzInfoLivingQna', :dependent => :destroy

  has_many :role, :as => :rolable, :class_name => "Role", :dependent => :destroy
  has_many :comment, :as => :commented_by, :dependent => :destroy
  has_many :attachment, :as => :attached_by, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached_by, :class_name => 'Image', :dependent => :destroy
  has_many :contact_us, :as => :contacted_by

  validates_presence_of :flyer_name
  after_create :create_mypage, :init_role
  
  PROVIDERS = Hash.new
  PROVIDERS[:facebook] = "facebook"
  PROVIDERS[:google] = "google_oauth2"
  PROVIDERS[:ozjapanese] = "ozjapanese"
  
  def init_role
    OzjapaneseStyle.headings.each do |page|
      role = Role.new(:role_name => page, :role_value => Role::R[:user_all])
      role.assign(self)
    end
  end
  
  def create_mypage
    #m = Mypage.create()
    #m.update_attribute(:mypagable, self)
  end

  # {
  # :provider => 'facebook',
  # :uid => '1234567',
  # :info => {
  # :nickname => 'jbloggs',
  # :email => 'joe@bloggs.com',
  # :name => 'Joe Bloggs',
  # :first_name => 'Joe',
  # :last_name => 'Bloggs',
  # :image => 'http://graph.facebook.com/1234567/picture?type=square',
  # :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
  # :location => 'Palo Alto, California',
  # :verified => true
  # },
  # :credentials => {
  # :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
  # :expires_at => 1321747205, # when the access token expires (it always will)
  # :expires => true # this will always be true
  # },
  # :extra => {
  # :raw_info => {
  # :id => '1234567',
  # :name => 'Joe Bloggs',
  # :first_name => 'Joe',
  # :last_name => 'Bloggs',
  # :link => 'http://www.facebook.com/jbloggs',
  # :username => 'jbloggs',
  # :location => { :id => '123456789', :name => 'Palo Alto, California' },
  # :gender => 'male',
  # :email => 'joe@bloggs.com',
  # :timezone => -8,
  # :locale => 'en_US',
  # :verified => true,
  # :updated_time => '2011-11-11T06:21:03+0000'
  # }
  # }
  # }

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :flyer_name
  attr_accessible :flyer_image
  attr_accessible :flyer_url
  # attr_accessible :title, :body
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    logger.info("find_for_facebook_oauth #{auth.provider} #{auth.uid}")
    user = Flyer.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.present?
      logger.info("User is to be created. email: #{auth.info.email}")
      user = Flyer.create(:flyer_name => auth.extra.raw_info.name,
      :provider => auth.provider,
      :uid => auth.uid,
      :email => auth.info.email,
      :password => Devise.friendly_token[0,20],
      :flyer_image => auth.info.image,
      :flyer_url => auth.extra.raw_info.link
    )
    end
    user
  end

  #access_token #<OmniAuth::AuthHash credentials=#<Hashie::Mash expires=true expires_at=1350894980 token="ya29.AHES6ZRIPUOUgRfWlo_4F3ZXQQ-MFopc9mYekj6jaJr6rmVTPxGH5g"> extra=#<Hashie::Mash raw_info=#<Hashie::Mash email="kenkenpa.kenichi@gmail.com" family_name="Takemura" gender="male" given_name="Kenichi" id="105992782623248923279" link="https://plus.google.com/105992782623248923279" locale="en-GB" name="Kenichi Takemura" verified_email=true>> info=#<OmniAuth::AuthHash::InfoHash email="kenkenpa.kenichi@gmail.com" first_name="Kenichi" last_name="Takemura" name="Kenichi Takemura"> provider="google_oauth2" uid="105992782623248923279">

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    logger.info("find_for_google_oauth2 access_token: #{access_token}")
    data = access_token.info
    provider = access_token.provider
    uid = access_token.uid
    link = access_token.extra.raw_info.link
    email = data["email"]
    logger.info("find_for_google_oauth2 #{provider} #{uid} #{link} #{email}")
    # I should say adding provider check because one can signin Facebook with gmail account
    user = Flyer.where(:provider => provider, :uid => uid).first
    if !user.present?
      logger.info("User is to be created. email: #{data["email"]}")
      user = Flyer.create(:flyer_name => data["name"],
      :provider => provider,
      :uid => uid,
      :email => email,
      :password => Devise.friendly_token[0,20],
      :flyer_url => link
    )
    end
    user
  end
  
  def facebook_flyer?
    self.provider.eql?(PROVIDERS[:facebook])
  end
  
  def google_flyer?
    self.provider.eql?(PROVIDERS[:google])
  end
  
  def ozjapanese_flyer?
    self.provider.eql?(PROVIDERS[:ozjapanese])
  end

  def agreed?
    self.agreed_on > Terms.terms_date
  end
  
  def agree
    self.update_attribute(:agreed_on, Common.current_time)
  end
  
  def joinedOn
    Common.date_format_ymdhm(agreed_on)
  end

end
