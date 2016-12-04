class AddDeliveryNote < ActiveRecord::Migration
  def change
    add_column :deliveries, :note, :string, limit: 3000

  end
end
