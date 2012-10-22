class CreateOzEmployments < CreateOzPosts
  def change
    create_base_table(:oz_employments)
  end
end
