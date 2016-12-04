class Api::V1::Driver::DeliveriesController < DriverApiController

  before_action :set_delivery, only: [:show]

  ###
  ## Show Delivery by ID
  ###
  def index
    inProgressDelivery = {}
    completedDeliveries = []
    waitingResponseDelivery = {}
    @deliveries = DriverAllocation.where('driver_id =? AND active = 1', @current_user.id).each do |driver_allocation|
      @delivery = Delivery.find(driver_allocation.delivery_id)
      if @delivery
        if @delivery.delivery_status_id == 5
        else
          inProgressDelivery = @delivery.as_json(:include => [:delivery_status, delivery_vehicle: {:include => :vehicle_types}], :methods => [:gapAsSeconds])
        end
      end
    end
    @current_user.completedDeliveries.each do |delivery|
      completedDeliveries << delivery.as_json(:include => [:delivery_status, delivery_vehicle: {:include => :vehicle_types}], :methods => [:gapAsSeconds])
    end
    @driverLocation = DriverLocation.driverOnHold(@current_user.id)
    if @driverLocation
      @allocations = DriverAllocation.where('driver_id =? AND active=0 AND completed=0', @current_user.id)
      if @allocations.length != 0
        @waitingDelivery = Delivery.find(@allocations[0].delivery_id)
        waitingResponseDelivery = @waitingDelivery.as_json(:include => [:delivery_status, delivery_vehicle: {:include => :vehicle_types}], :methods => [:gapAsSeconds])
      end
    end
    render :json => {:success => :true, :completed_deliveries => completedDeliveries, :current_delivery => inProgressDelivery, :delivery_statuses => DeliveryStatus.getAllASJson(), :waitingResponseDelivery => waitingResponseDelivery}
  end


  ###
  ## Show Delivery by ID
  ###
  def show
    if @delivery
      render :json => {:success => :true, :delivery => @delivery.as_json(:include => :delivery_status), :delivery_statuses => DeliveryStatus.getAllASJson(), :second_gap => (Time.parse(DateTime.now.to_s) - Time.parse(@delivery.created_at.to_s))}
    else
      render :json => {:success => :false, :errors => ['You dont have delivery']}, status: 422
    end
  end


  ###
  ## Change Status
  ###
  def changeStatus
    @driverLocation = DriverLocation.driverOnHold(@current_user.id)
    
    if @driverLocation
        
      @allocations = DriverAllocation.where('driver_id =? AND delivery_id=? AND active=0 AND completed=0', @current_user.id, params[:delivery_id])
      
      if @allocations.length !=
        @delivery = Delivery.find(@allocations[0].delivery_id)
        
        if params[:accept] == '1'
          @driverLocation.driver_status_id = 3
          @allocations[0].active = 1
          @delivery.delivery_status_id = 2
          @delivery.driver_id = @current_user.id
          @delivery.setUpdatedTime
          @delivery.save
          @delivery.sendPushForUser("#{@current_user.first_name} accepted the delivery")
          logger.debug "DRIVER DEVICE ACCEPTED THE DELIVARY"
        else
          @driverLocation.driver_status_id = 1
          @allocations[0].active = 2
         # @tempAllocations[0].active = 2
          @delivery.sendPushForUser("#{@current_user.first_name} rejected the delivery")
          logger.debug "DRIVER DEVICE REJECTED THE DELIVARY"
          driverLocations = DriverLocation.all_drivers(@delivery.delivery_vehicle.drivers.collect(&:id))
          newDriverLocation = DriverLocation.getNearestDriverWithIgnore(@delivery.from_lat, @delivery.from_lon, DriverAllocation.notAvailableIdList(@delivery.id), driverLocations.collect(&:id))
          if newDriverLocation
            Delivery.newAllocation(newDriverLocation, params[:delivery_id])
          else
            @driverLocation.save
            logger.debug 'new allocation'
            @delivery.allocate
          end
        end
        @driverLocation.save
        @allocations[0].save
        @current_user.manualAllocation
        render :json => {:success => :true, :message => 'status changed'}, status: 200
      else
        render :json => {:success => :false, :errors => ['You dont have an allocation now']}, status: 422
      end
    else
      if params[:reject]
        @dLocation = DriverLocation.driverOnADelivery(@current_user.id)
        if @dLocation
          if params[:accept] != '1'
            logger.debug 'calling reject'
            @allocations = DriverAllocation.where('driver_id =? AND delivery_id=? AND active=1 AND completed=0', @current_user.id, params[:delivery_id])
            #@tempAllocations = TempAllocation.where('driver_id =? AND delivery_id=? AND active=0 AND completed=0', @current_user.id, params[:delivery_id])
            if @allocations.length != 0
              @delivery = Delivery.find(@allocations[0].delivery_id)
              @delivery.driver_id = 0
              @delivery.delivery_status_id = 1
              @delivery.save
              @dLocation.driver_status_id = 1
              @allocations[0].active = 2
              @delivery.sendPushForUser("#{@current_user.first_name} rejected the delivery")
              logger.debug "DRIVER DEVICE REJECTED THE DELIVARY"
              driverLocations = DriverLocation.all_drivers(@delivery.delivery_vehicle.drivers.collect(&:id))
              newDriverLocation = DriverLocation.getNearestDriverWithIgnore(@delivery.from_lat, @delivery.from_lon, DriverAllocation.notAvailableIdList(@delivery.id), driverLocations.collect(&:id))
              logger.debug 'call new driver api allocation'
              if newDriverLocation
                Delivery.newAllocation(newDriverLocation, params[:delivery_id])
              else
                @dLocation.save
                logger.debug 'new allocation'
                @delivery.allocate
              end
            end
            @dLocation.save
            @allocations[0].save
            @current_user.manualAllocation
            #Delivery.re_allocate
            render :json => {:success => :true, :message => 'status changed'}, status: 200
          else
            render :json => {:success => :false, :errors => ['wrong parameters']}, status: 422
          end
        else
          render :json => {:success => :false, :errors => ['You dont have allocation now']}, status: 422
        end
      else
        render :json => {:success => :false, :errors => ['You dont have allocation now']}, status: 422
      end
    end
  end



  ###
  ## Change Delivery Status
  ###
  def changeDeliveryStatus
    @deliveries = DriverAllocation.joins(:deliveries).where('driver_allocations.driver_id =? AND driver_allocations.active = 1 AND deliveries.delivery_status_id!=5', @current_user.id)
    
    if @deliveries.length !=
      @deliveryAllocation = @deliveries[0]
      
      @delivery = @deliveryAllocation.getDelivery()
      
      if @delivery.delivery_status_id + 1 == params[:status_id].to_i
        @delivery.delivery_status_id = @delivery.delivery_status_id + 1
        if @delivery.delivery_status_id == 2
          @delivery.sendPushForUser("#{@current_user.first_name} en route To pick up the delivery")
          logger.debug "DRIVER DEVICE en route To pick up the delivery"
        elsif @delivery.delivery_status_id == 3
          @delivery.sendPushForUser("#{@current_user.first_name} picked up the delivery")
          logger.debug "DRIVER DEVICE picked up the delivery"
        elsif @delivery.delivery_status_id == 4
          @delivery.sendPushForUser("#{@current_user.first_name} en route to deliver")
          logger.debug "DRIVER DEVICE en route to deliver"
        elsif @delivery.delivery_status_id == 5
          @delivery.sendPushForUser("#{@current_user.first_name} delivered the delivery")
          logger.debug "DRIVER DEVICE delivered the delivery"
        end

        if params[:status_id].to_i == 5
          if (params[:signature])
            @deliveryAllocation.active = 0
            @deliveryAllocation.completed = 1
            @deliveryAllocation.save
            @delivery.signature = params[:signature]
            @delivery.signature_name = params[:signature_name]
            @delivery.save
            @driverLocation = DriverLocation.driverOnADelivery(@current_user.id)
            if @driverLocation
              @driverLocation.setAsAvailable
            end
            @current_user.manualAllocation
            Delivery.re_allocate
            render :json => {:success => :true, :delivery => @delivery.as_json(:include => [:delivery_status, delivery_vehicle: {:include => :vehicle_types}]), :delivery_statuses => DeliveryStatus.getAllASJson()}
          else
            render :json => {:success => :false, :errors => ['signature missing']}
          end
        else
          @delivery.signature_name = params[:signature_name]
          @delivery.save
          render :json => {:success => :true, :delivery => @delivery.as_json(:include => [:delivery_status, delivery_vehicle: {:include => :vehicle_types}]), :delivery_statuses => DeliveryStatus.getAllASJson()}
        end
      else
        render :json => {:success => :false, :errors => ['wrong delivery status']}, status: 422
      end
    else
      render :json => {:success => :false, :errors => ['You dont have delivery']}, status: 422
    end
  end

  private
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end
end