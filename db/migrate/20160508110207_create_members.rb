class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.boolean :is_visible
      t.attachment :image
      t.string :dog_name
      t.string :member_name
      t.string :member_phone
      t.string :member_email
      t.timestamps
    end

    create_table :member_uploads do |t|
      t.boolean :is_visible
      t.attachment :image
      t.string :dog_name
      t.string :member_name
      t.string :member_phone
      t.string :member_email
      t.timestamps
    end
  end
end
