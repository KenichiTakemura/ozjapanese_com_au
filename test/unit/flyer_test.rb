require 'test_helper'

class FlyerTest < ActiveSupport::TestCase

  def model_case1(model)
    puts "%%% #{model} test %%%"
    assert flyer = flyer?
    assert post = add_post(model, flyer)
    assert !post.has_image
    assert !post.has_image?
    assert image = add_image(post, flyer)
    assert post.has_image
    assert post.has_image?
    assert Image.attached_for(post).size, 1
    assert comment = add_comment(post, flyer)
    post = model.find(post)
    assert_equal TopFeedList.recent_top_feed(1).size, 1
    assert_equal model.search(1).size, 1
    assert_equal post.comment.size, 1
    assert_equal Comment.comment_for(post).size, 1
    assert_equal Content.content_for(post).size, 1
    flyer.destroy
    assert_equal TopFeedList.recent_top_feed(1).size, 0
    assert_equal model.search(1).size, 0
    assert_equal Comment.comment_for(post).size, 0
    assert_equal Content.content_for(post).size, 0
    assert Image.attached_for(post).size, 0
  end
  
  test "model_case1" do
    OzjapaneseStyle.headings.each do |heading|
      model_case1(OzjapaneseStyle.heading_model(heading))
    end
  end

end
