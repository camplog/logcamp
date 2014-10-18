class CreateApplicationsUsers < ActiveRecord::Migration
  def change
    create_table :applications_users, id: false do |t|
      t.belongs_to :application, index: true
      t.belongs_to :user,        index: true
    end

    add_index :applications_users, [:application_id, :user_id], unique: true
  end
end
