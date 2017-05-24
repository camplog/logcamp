class SorceryCore < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string   :email,                               null: false
      t.string   :full_name
      t.string   :github_login
      t.boolean  :admin,                               default: false
      t.integer  :applications_count,                  default: 0
      t.integer  :searches_count,                      default: 0
      t.string   :crypted_password,                    null: false
      t.string   :salt,                                null: false

      t.string   :remember_me_token,                   default: nil
      t.datetime :remember_me_token_expires_at,        default: nil

      t.string   :reset_password_token,                default: nil
      t.datetime :reset_password_token_expires_at,     default: nil
      t.datetime :reset_password_email_sent_at,        default: nil

      t.string   :users, :activation_state,            default: nil
      t.string   :users, :activation_token,            default: nil
      t.datetime :users, :activation_token_expires_at, default: nil

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_me_token
    add_index :users, :reset_password_token
    add_index :users, :activation_token
  end
end
