class ChangeStartDateToDateTimeInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :start_date, :datetime
    change_column :events, :end_date, :datetime
  end
end
