class CreateOzSellGoods < CreateOzPosts
  def change
    create_base_table(:oz_sell_goods)
  end
end