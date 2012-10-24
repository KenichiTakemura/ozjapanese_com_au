class CreateOzPeoplePros < CreateOzPosts
  def change
    create_base_table(:oz_people_pros)
  end
end
