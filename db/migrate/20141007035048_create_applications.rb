class CreateApplications < ActiveRecord::Migration[4.2]
  def change
    create_table :applications do |t|
      t.string  :name
      t.string  :slug
      t.boolean :active, default: true
      t.string  :identicon
      t.string  :auth_token
      t.integer :owner_id

      t.timestamps null: false
    end
    add_index :applications, :owner_id
  end
end
