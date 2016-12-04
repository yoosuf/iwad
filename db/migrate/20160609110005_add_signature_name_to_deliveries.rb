class AddSignatureNameToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :signature_name, :string
  end
end
