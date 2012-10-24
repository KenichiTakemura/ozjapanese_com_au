class CreateOzInfoEvents < CreateOzPosts
  def change
    create_base_table(:oz_info_events)
  end
end
