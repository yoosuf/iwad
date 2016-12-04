class AddMoreFieldsToDriverTable < ActiveRecord::Migration
  def change
    add_column :drivers, :title, :string
    add_column :drivers, :first_name, :string
    add_column :drivers, :surname, :string
    add_column :drivers, :middle_name, :string
    add_column :drivers, :mobile_no, :string
    add_column :drivers, :land_no, :string
    add_column :drivers, :gender, :string, limit: 6
  end
end
