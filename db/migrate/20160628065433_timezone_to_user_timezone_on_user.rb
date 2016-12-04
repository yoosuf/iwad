class TimezoneToUserTimezoneOnUser < ActiveRecord::Migration
  def change
    rename_column :users, :timezone, :user_timezone

  end
end
