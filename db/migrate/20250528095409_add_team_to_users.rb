class AddTeamToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :team, :string
  end
end
