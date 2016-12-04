class AddDofToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :date_of_birth, :date

  end
end
