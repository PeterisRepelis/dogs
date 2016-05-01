class CreatePages < ActiveRecord::Migration
    def change
      create_table :pages do |t|
        t.integer :position, :default => 0
        t.integer :parent_id
        t.boolean :visible
        t.string :page_link
        t.boolean :root_page, :default => false
        t.boolean :blank_page, :default => false
        t.attachment :image
        t.attachment :video 
        t.integer :background_type, :default => 1
        t.string :bacground_color, :default => "#fffff"
        t.string :ancestry
        t.boolean :show_title
        t.string :page_height
        t.integer :content_position
        t.integer :page_type
        t.boolean :use_html_page, :default => false
        t.integer :layout_type
        t.integer :html_page
        t.integer :resource_id
        t.string :resource_type
        t.string :title
        t.text :content
        t.string :friendly_id
        t.string :slug
        t.timestamps
      end
    end
  end
