class OzSellGoodsController < OzPostsController

  def filter
    @heading = :ozj_h3
  end


  def create
    create_post(OzSellGood, :oz_sell_good)
  end
end
