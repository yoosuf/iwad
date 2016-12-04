class CreateDriverAllocations < ActiveRecord::Migration
  def change
    create_table :driver_allocations do |t|
      t.integer         :driver_id
      t.integer         :delivery_id
      t.integer         :active ,  default: 0, null: false
      t.timestamps null: false
    end
  end
end
