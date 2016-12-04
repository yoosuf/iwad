class VehicleType < ActiveRecord::Base
  has_many :delivery_vehicles
  has_many :drivers

end
