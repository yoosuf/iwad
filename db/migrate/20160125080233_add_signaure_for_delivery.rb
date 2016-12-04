class AddSignaureForDelivery < ActiveRecord::Migration
  def self.up
    change_table :deliveries do |t|
      t.attachment :signature
    end
  end

  def self.down
  end
end
