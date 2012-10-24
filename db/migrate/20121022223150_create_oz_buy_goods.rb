class CreateOzBuyGoods < CreateOzPosts
  def change
    create_base_table(:oz_buy_goods)
  end
end