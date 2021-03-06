class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string  :status
      t.text    :message
      t.json    :metadata
      t.boolean :alert, default: false
      t.string  :keywords
      t.integer :application_id

      t.timestamps null: false
    end
    add_index :events, :application_id
  end
end
