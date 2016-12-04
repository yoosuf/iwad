class AddNoOfPeopleForDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :no_of_people, :integer
  end
end
