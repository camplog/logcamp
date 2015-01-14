class RemoveGithubLoginFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :github_login, :string
  end
end
