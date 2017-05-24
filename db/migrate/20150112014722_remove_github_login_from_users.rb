class RemoveGithubLoginFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :github_login, :string
  end
end
