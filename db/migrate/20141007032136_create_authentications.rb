class CreateAuthentications < ActiveRecord::Migration[4.2]
  def change
    create_table :authentications do |t|
    	t.string  :provider
    	t.string  :uid
    	t.string  :provider_username
    	t.string  :provider_token
    	t.string  :user_id

      t.timestamps null: false
    end
    add_index :authentications, [:provider, :uid]
    add_index :authentications, :user_id
  end
end
