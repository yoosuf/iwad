class AddCanceledAtToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :canceled_at, :datetime, null: true
  end
end
