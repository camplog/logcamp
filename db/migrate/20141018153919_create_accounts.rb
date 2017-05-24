class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.integer :owner_id

      t.timestamps null: false
    end
    add_index :accounts, :owner_id
  end
end
