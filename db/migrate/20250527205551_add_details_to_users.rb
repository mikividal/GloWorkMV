class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :location, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :job_position, :string
    add_column :users, :admin, :boolean, default: false
  end
end
