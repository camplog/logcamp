class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string  :name
      t.string  :slug
      t.boolean :active, default: true
      t.string  :identicon
      t.string  :auth_token
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :applications, :user_id
  end
end
