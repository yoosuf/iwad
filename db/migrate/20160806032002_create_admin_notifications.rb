class CreateAdminNotifications < ActiveRecord::Migration
  def change
    create_table :admin_notifications do |t|
      t.string :name
      t.string :email
      t.string :time_zone
      t.boolean :status

      t.timestamps null: false
    end
  end
end
