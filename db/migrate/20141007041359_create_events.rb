class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :status
      t.text    :message
      t.integer :application_id

      t.timestamps null: false
    end
    add_index :events, :application_id
  end
end
