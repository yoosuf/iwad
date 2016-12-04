class RenameTimezoneField < ActiveRecord::Migration
  def change
    rename_column :users, :user_timezone, :time_zone
    rename_column :drivers, :timezone, :time_zone
  end
end
