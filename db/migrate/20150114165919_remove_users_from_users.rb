class RemoveUsersFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :users, :datetime
  end
end
