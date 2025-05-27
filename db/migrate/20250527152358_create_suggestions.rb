class CreateSuggestions < ActiveRecord::Migration[7.1]
  def change
    create_table :suggestions do |t|
      t.string :suggestion
      t.date :date
      t.boolean :actioned

      t.timestamps
    end
  end
end
