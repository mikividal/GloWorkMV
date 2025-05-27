class CreateMoodtrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :moodtrackers do |t|
      t.integer :mood
      t.date :date
      t.text :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
