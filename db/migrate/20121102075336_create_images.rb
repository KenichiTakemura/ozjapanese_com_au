class CreateImages < CreateAttachables
  def change
    create_base_table(:images)
    add_column :images, :something, :string, :limit => Image::IMAGE_SOMETHING_LENGTH
    add_column :images, :source_url, :string
    add_column :images, :link_to_url, :string
  end
end