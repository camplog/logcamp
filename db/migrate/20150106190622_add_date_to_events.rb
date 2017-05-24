class AddDateToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :date, :datetime
  end
end
