class CreateOzInfoLivingSmarts < CreateOzPosts
  def change
    create_base_table(:oz_info_living_smarts)
  end
end
