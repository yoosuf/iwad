class AddHealthFields < ActiveRecord::Migration
  def change
    add_column :drivers, :no_of_absent_dates, :integer
    add_column :drivers, :absent_desc, :string

  end
end
