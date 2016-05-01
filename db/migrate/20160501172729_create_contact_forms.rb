class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :name
      t.string :dog_name
      t.string :email
      t.string :phone
      t.text :comment
      t.string :ip_address
      t.string :browser
      t.integer :state, default: 1
      t.timestamps
    end
  end
end