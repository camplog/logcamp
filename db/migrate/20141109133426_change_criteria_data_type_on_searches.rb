class ChangeCriteriaDataTypeOnSearches < ActiveRecord::Migration
  def change
    change_column :searches, :criteria, :string
  end
end
