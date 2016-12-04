class AddDriverIdToEmployment < ActiveRecord::Migration
  def change
    add_column :employments, :driver_id, :integer, null: false,  default: 0
  end
end
