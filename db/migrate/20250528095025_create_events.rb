class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :start_date
      t.date :end_date
      t.string :location
      t.text :description
      t.timestamps
    end
  end
end
