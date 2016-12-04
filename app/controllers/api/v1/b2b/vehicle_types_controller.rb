class Api::V1::B2b::VehicleTypesController < UserApiController

  api :GET, '/v1/b2b/vehicle_types/', 'Fetch all vehicle types in the system'
  formats ['json']
  description <<-EOS
      == Long description
       Example vehicle types include
       Car / Van / Moto Bike
    EOS
  def index
    vTypes = []

    VehicleType.all().each do |t|
      vTypes << t.as_json(:include => :delivery_vehicles)
    end

    render :json => {:success => :true , :vehicleTypes => vTypes}
  end
end
