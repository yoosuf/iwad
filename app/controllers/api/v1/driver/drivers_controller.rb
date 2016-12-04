class Api::V1::Driver::DriversController < DriverApiController

  before_filter :authenticate, :except => [:login]

  def login
    driver = Driver.login(params[:email], params[:password])
    if driver.present?

      if driver[0].status == true

        if driver[0].is_delete == 1
          render :json => {:success => :false, :errors => ['Your account has been suspended']}
        else
          if params[:push_token] && params[:device_type]
            driver[0].updateDriverDevice(params[:push_token], params[:device_type])
            driver[0].new_token!
          end
          #driver[0].manualAllocation
          #Delivery.re_allocate
          render :json => {:success => :true , :driver => driver[0].as_json(:methods => [:avatar_url])}
        end
      else
        render :json => {:success => :false, :errors => ['Your account has not been approved yet']}
      end
      
    else
      render :json => {:success => :false, :errors => ['Email password combination invalid']}
    end
  end

  def update_location

    if params[:lat] && params[:lon]
      @driver_locations = DriverLocation.find_by_driver_id(@current_user.id)
      @driver_location = DriverLocation.new()
      @driver_location.driver_status_id = 1
      if @driver_locations
        @driver_location = @driver_locations
      else
        #Delivery.re_allocate
      end

      @driver_location.driver_id  = @current_user.id
      @driver_location.lat        = params[:lat]
      @driver_location.lon        = params[:lon]
      @driver_location.save

      Delivery.resetAllocations()

      current_user.manualAllocation
      Delivery.re_allocate

      render :json => {:success => :true , :message => 'updated successfully'}
    else
      render :json => {:success => :false , :errors => ['field(s) are blank']}
    end
    Rails.logger.debug "DRIVER #{@current_user.id}"

  end

  def show
    if @current_user
      render :json => {:success => :true , :driver => @current_user.as_json(:methods => [:avatar_url])}
    else
      render :json => {:success => :false , :errors => ['You dont have driver details']}
    end
  end

  def update
    if @current_user.update(driver_update_params)

      render :json => {:success => :true , :driver => @current_user.as_json(:methods => [:avatar_url])}

      Rails.logger.info("LAHIRU IS TRYING TO UPDATE #{@current_user}")

    else
      render :json => {:success => :false , :errors => @current_user.errors.full_messages}
    end
  end

  def change_password
    if params[:password] && params[:confirm_password] && params[:old_password]
      if params[:password] == params[:confirm_password]

        if @current_user.session_token == Digest::SHA1.hexdigest(params[:old_password])
          @current_user.updatePassword(params[:password])
          render :json => {:success => :true , :user =>  @current_user.as_json(:methods => [:avatar_url])}
        else
          render :json => {:success => :false , :errors => ['old password does not match']}
        end
      else
        render :json => {:success => :false , :errors => ['password does not match']}
      end
    else
      render :json => {:success => :false , :errors => ['field are blanks']}
    end
  end

  def logout
    if params[:push_token] && params[:device_type]
      current_user.removeDevices(params[:push_token], params[:device_type])
      current_user.removeLocations
      render :json => {:success => :true , :message => 'log out'}
    else
      render :json => {:success => :false , :errors => ['field are blanks']}
    end
  end

  def earnings
    render :json => {:success => :true , :totalCostMonthly => current_user.getTotalCostForCompletedDeliveriesMonthly, :commissionMonthly => current_user.getCommissionMonthly, :totalCostToday => current_user.getTotalCostForCompletedDeliveriesToday, :commissionToday => current_user.getCommissionToday, :deliveryCountMonthly => current_user.getTotalCostForCompletedDeliveryCountMonthly, :deliveryCountToday => current_user.getTotalCostForCompletedDeliveryCountToday}
  end

  def remove_availability
    if params[:availability] == '1'
      current_user.goOnline
    else
      current_user.goOffline
    end
    render :json => {:success => :true , :message => 'availability changed'}
  end

  def driver_update_params
    params.require(:driver).permit(:first_name, :date_of_birth, :gender, :mobile_no,:surname, :middle_name, :avatar,  :country_code)
  end
end
