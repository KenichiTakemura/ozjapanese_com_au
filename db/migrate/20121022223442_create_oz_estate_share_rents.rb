class CreateOzEstateShareRents < CreateOzPosts
  def change
    create_base_table(:oz_estate_share_rents)
  end
end