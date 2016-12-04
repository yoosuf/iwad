class CreateDeliveryStatuses < ActiveRecord::Migration
  def change
    create_table :delivery_statuses do |t|
      t.string    :status
      t.string    :info
      t.timestamps null: false
    end
  end
end
