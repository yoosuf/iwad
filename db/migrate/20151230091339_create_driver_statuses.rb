class CreateDriverStatuses < ActiveRecord::Migration
  def change
    create_table :driver_statuses do |t|
      t.string    :status
      t.string    :info
      t.timestamps null: false
    end
  end
end
