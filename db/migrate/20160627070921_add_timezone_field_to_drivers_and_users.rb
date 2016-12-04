class AddTimezoneFieldToDriversAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string, null: true
    add_column :drivers, :timezone, :string, null: true
  end
end
