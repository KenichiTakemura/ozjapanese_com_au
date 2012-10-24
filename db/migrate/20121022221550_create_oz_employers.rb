class CreateOzEmployers < CreateOzPosts
  def change
    create_base_table(:oz_employers)
  end
end
