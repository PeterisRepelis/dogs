class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :position, :default => 0
      t.boolean :visible, :default => true
      t.attachment :cover_image
      t.string :title
      t.timestamps
    end

    create_table :album_images do |t|
      t.integer :album_id
      t.string :title
      t.integer :position, :default => 0
      t.attachment :image 
      t.timestamps
    end

  end
end

