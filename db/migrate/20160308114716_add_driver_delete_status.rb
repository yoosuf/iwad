class AddDriverDeleteStatus < ActiveRecord::Migration
  def change
    add_column :drivers, :is_delete, :integer, default:0
  end
end
