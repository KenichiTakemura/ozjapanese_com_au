ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  def flyer?
    flyer = Flyer.first
    if !flyer.present?
      flyer = Flyer.create(:email => "ktakemur@localhost.com", :password => 'kenichi123',
        :password_confirmation => 'kenichi123', :flyer_name => "Kenichi Takemura", :provider => Flyer::PROVIDERS[:ozjapanese])
      flyer
    end
    flyer
  end
  
  def add_post(model, flyer)
    expiry = Common.current_time + 60.days
    subject = "法相・滝氏、午後に認証式＝拉致相は官房長官兼務"
    html = "藤村修官房長官は２４日午前の記者会見で、暴力団関係者との交際や外国人献金問題などで辞任した田中慶秋法相兼拉致問題担当相の後任に滝実前法相（７４）を再起用すると発表した。"
    post = model.new(:subject => subject, :valid_until => expiry);
    post.created_at = Common.current_time
    content = post.build_content(:body => html)
    post.save
    post.set_user(flyer)
    content.save
    post
  end
  
  def add_image(post, flyer)
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image.attached_to_by(post, flyer)
    image
  end
  
  def add_comment(post, flyer)
    comment = Comment.new(:body => "コメント #{post.id}!?")  
    comment.save
    comment.subscribe_to(post, flyer)
    comment
  end
  
end
