class DeliveryVehicle < ActiveRecord::Base
  belongs_to :vehicle_types, :class_name => "VehicleType", :foreign_key => "vehicle_type_id"

  has_many :drivers

  def get_next_larger_vehicle
    DeliveryVehicle.find_by(vehicle_size: self.vehicle_size + 1, vehicle_type_id: self.vehicle_type_id)
  end

  def self.fetchWithVehicleTypes
    allTypes = []

    self.all.each do | delivery_vehicle |
      allTypes <<  ["#{delivery_vehicle.vehicle_types.name} - #{delivery_vehicle.name}", delivery_vehicle.id]
    end

    allTypes
  end
end
