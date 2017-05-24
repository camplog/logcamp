class ChangeCriteriaDataTypeOnSearches < ActiveRecord::Migration[4.2]
  def change
    change_column :searches, :criteria, :string
  end
end
