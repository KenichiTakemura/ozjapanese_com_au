class CreateOzPosts < ActiveRecord::Migration
  def create_base_table(table)
    create_table(table,:options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :locale, :null => false
      t.references :posted_by, :polymorphic => true
      t.references :post_updated_by, :polymorphic => true
      t.string :requested_by, :null => true
      t.integer :category, :null => false
      t.string :subject, :null => false
      t.datetime :valid_until, :null => false
      t.integer :views, :default => 0
      t.integer :status, :null => false
      t.integer :z_index, :default => 0
      t.integer :write_at, :null => true
      t.integer :mode, :null => true
      t.boolean :has_image, :default => false
      t.boolean :has_attachment, :default => false
      t.boolean :sns_feeded, :default => false
      t.string :sns_provider, :null => true
      t.timestamps
    end
    add_index table, :z_index
  end
end
