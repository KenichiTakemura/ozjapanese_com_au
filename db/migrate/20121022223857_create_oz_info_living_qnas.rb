class CreateOzInfoLivingQnas < CreateOzPosts
  def change
    create_base_table(:oz_info_living_qnas)
  end
end
