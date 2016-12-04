class Api::V1::B2b::DriversController < UserApiController

  before_action :set_driver, only: [:show]

  api :GET, '/v1/b2b/drivers/', 'Fetch all drivers in the system'
  formats ['json']
  description <<-EOS
      == Long description
       Get the list of deliveries related to your account as
       identified by the X-Auth-Token
    EOS
  def index
    allAvailableDrivers = []

    if params[:allDrivers]
      DriverLocation.allDrivers().each do |driver_allocation|
        allAvailableDrivers << driver_allocation.as_json(:include => {driver: {
          :methods => [:avatar_url, :lat, :lon], only: [:first_name, :surname,:middle_name , :mobile_no, :land_no]}
        })
      end
    elsif params[:vehicle_type_id]
      DriverLocation.allDrivers.drivers_by_vehicle_type(params[:vehicle_type_id]).each do |driver_allocation|
        allAvailableDrivers << driver_allocation.as_json(:include => {driver: {
          :methods => [:avatar_url, :lat, :lon], only: [:first_name, :surname, :middle_name, :mobile_no, :land_no]}
        })
      end
    else
      DriverLocation.allAvailableDrivers().each do |driver_allocation|
        allAvailableDrivers << driver_allocation.as_json(:include => {driver: {
          :methods => [:avatar_url, :lat, :lon], only: [:first_name, :surname, :middle_name, :mobile_no, :land_no]}
        })
      end
    end

    render :json => {:success => :true , :drivers => allAvailableDrivers}
  end

  def show
    if @driver
      render :json => {:success => :true , :driver => @driver.as_json(:methods => [:avatar_url, :lat, :lon], :only => [:first_name, :surname, :middle_name, :mobile_no, :land_no])}
    else
      render :json => {:success => :false , :errors => ['You dont have driver details']}, status: 404
    end
  end

  private

    def set_driver
      @driver = Driver.find(params[:id])
    end
end
