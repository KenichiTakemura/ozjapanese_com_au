class OzBuyGoodsController < OzPostsController

  def filter
    @heading = :ozj_h4
  end


  def create
    create_post(OzBuyGood, :oz_buy_good)
  end
end
