class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string  :name
      t.string  :color
      t.json    :criteria
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :searches, :user_id
  end
end
