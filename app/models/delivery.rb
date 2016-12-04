class Delivery < ActiveRecord::Base
  belongs_to :delivery_status, :class_name => "DeliveryStatus", :foreign_key => "delivery_status_id"
  belongs_to :driver, :class_name => "Driver", :foreign_key => "driver_id"
  belongs_to :delivery_vehicle, :class_name => "DeliveryVehicle", :foreign_key => "delivery_vehicle_id"
  belongs_to :temp_delivery_vehicle, :class_name => "DeliveryVehicle", :foreign_key => "temp_delivery_vehicle_id"
  belongs_to :user

  has_many :temp_allocations


  validates :name, presence: true

  # @todo
  # Uncomment on Phase 3 Development
  #validates :email, phone: true
  #validates :delivery_number, phone: true

  validates :from_location, presence: true
  validates :to_location, presence: true
  validates :delivery_vehicle_id, presence: true

  #before_create :resetAllocations
  after_create :allocate
  after_create :setDriversCommission

  has_attached_file :signature,
                    :path => ":rails_root/public/assets/deliveries/signature/:id/:style/:basename.:extension",
                    :url => "/assets/deliveries/signature/:id/:style/:basename.:extension"

  validates_attachment :signature,
                       :content_type => {:content_type => ["image/png", "image/jpg", "image/jpeg"]},
                       :size => {:in => 0..20.megabytes}


  def getJSON(options = {})
    obj = self.as_json(:include => [:delivery_status, driver: {only: [:id, :first_name, :surname, :middle_name, :avatar], :methods => [:avatar_url, :lat, :lon]}])
    obj[:delivery_vehicle] = self.delivery_vehicle.as_json(:include => :vehicle_types)
    return obj
  end

  def allocate
    if self.delivery_date
      if self.delivery_date < DateTime.now.utc
        self.createAllocation
      end
    else
      self.createAllocation
    end
  end

  def createAllocation

    if self.manual != 0
      @driver = Driver.find(self.driver_id)

      logger.info "INITIALISING request... #{@driver}"

      @locations = DriverAllocation.where('(active = 1 OR active = 3 OR completed = 1) AND delivery_id=?', self.id)
      if @locations.length == 0
        if @driver.isAvailable
          @location = @driver.isAvailable
          @location.driver_status_id = 3
          @location.save

          @driverAllocation = DriverAllocation.new
          @driverAllocation.driver_id = self.driver_id
          @driverAllocation.delivery_id = self.id
          @driverAllocation.attempt_count += 1
          @driverAllocation.active = 1
          @driverAllocation.save

          # @tempAllocation = TempAllocation.new
          # @tempAllocation.driver_id = self.driver_id
          # @tempAllocation.delivery_id = self.id
          # @tempAllocation.active = 1
          # @tempAllocation.save

          self.delivery_status_id = 1
          self.save

          self.sendPushNotification(@driverAllocation.driver_id, "New delivery received for a #{self.delivery_vehicle.name}")
        else

          @driverAllocation = DriverAllocation.new
          @driverAllocation.driver_id = self.driver_id
          @driverAllocation.attempt_count += 1
          @driverAllocation.delivery_id = self.id
          @driverAllocation.active = 3
          @driverAllocation.save

          # @tempAllocation = TempAllocation.new
          # @tempAllocation.driver_id = self.driver_id
          # @tempAllocation.delivery_id = self.id
          # @tempAllocation.active = 3
          # @tempAllocation.save


          self.sendPushNotification(@driverAllocation.driver_id, "New delivery received for a #{self.delivery_vehicle.name}")
        end
      end
    else
      # Rails.logger.debug "Email is to sent"
      # if self.created_at + 10*60 <= Time.now
      #   Rails.logger.debug "The delivery has excieded 10 min window"
      #   self.sendCancellationEmail
      # end

      self.allocateWithNearestDriverWitAllDrivers(self.id)
    end
  end

  def allocateWithNearestDriverWitAllDrivers(delivery_id)
    driverLocations = DriverLocation.all_drivers(self.delivery_vehicle.drivers.collect(&:id))
    driverLocation = DriverLocation.getNearestDriverWithIgnore(self.from_lat, self.from_lon, DriverAllocation.notAvailableIdListForReject(delivery_id), driverLocations.collect(&:id))

    if driverLocation
      Delivery.newAllocation(driverLocation, delivery_id)
      # self.sendPushNotification("New delivery received for a #{self.delivery_vehicle.name}")

    else
      logger.debug 'no users to allocate'
    end
  end

  def go_to_next_driver
    not_available_drivers = DriverAllocation.notAvailableIdListForReject(self.id)
    drivers_didnt_respond = DriverAllocation.no_response(self.id)
    remaining_new_drivers = self.delivery_vehicle.drivers.collect(&:id) - drivers_didnt_respond
    driverLocation = DriverLocation.getNearestDriverWithIgnore(self.from_lat, self.from_lon, not_available_drivers, remaining_new_drivers)

    if remaining_new_drivers.length == 0 || driverLocation.nil?
      begin
        temp_delivery = nil
        if self.temp_delivery_vehicle.nil?
          temp_delivery = self.delivery_vehicle.get_next_larger_vehicle
        else
          temp_delivery = self.temp_delivery_vehicle.get_next_larger_vehicle
        end

        puts "================= temp_delivery #{temp_delivery.inspect} ================="

        self.temp_delivery_vehicle = temp_delivery
        self.save

        remaining_new_drivers = temp_delivery.nil? ? [] : temp_delivery.drivers.collect(&:id)

        driverLocation = DriverLocation.getNearestDriverWithIgnore(self.from_lat, self.from_lon, not_available_drivers, remaining_new_drivers)
      end while driverLocation.nil? && !temp_delivery.nil?
    end

    driverLocation = DriverLocation.getNearestDriverWithIgnore(self.from_lat, self.from_lon, not_available_drivers, remaining_new_drivers)
    if driverLocation
      Delivery.newAllocation(driverLocation, self.id)


    else
      logger.debug "no users to allocate"
    end
  end

  def allocateWithNearestDriverWithIgnoreDrivers(delivery)
    delivery.go_to_next_driver
    # newDriverLocation = DriverLocation.getNearestDriverWithIgnore(delivery.from_lat, delivery.from_lon, DriverAllocation.notAvailableIdList(delivery.id))
    # if newDriverLocation
    #   Delivery.newAllocation(newDriverLocation, delivery.id)
    #   # self.sendPushNotification("New delivery received for a #{self.delivery_vehicle.name}")
    # else
    #   delivery.allocateWithNearestDriverWitAllDrivers(delivery.id)
    #   logger.debug 'no location'
    # end
  end

  def self.re_allocate

    logger.debug '==================================== RE ALLOCATION ===================================='

    Delivery.where('delivery_status_id = 1').each do |delivery|
      @locations = DriverAllocation.where('(active != 1 AND active != 3)   AND completed = 0 AND delivery_id=?', delivery.id)

      if delivery.delivery_date
        Time.zone = 'UTC'

          @locations = DriverAllocation.where('(active != 1 AND active != 3)   AND completed = 0 AND delivery_id=?', delivery.id)
          if @locations.length > 0

            logger.debug '==================================== RE ALLOCATION - LOCATION COUNT ===================================='


            if DriverAllocation.where('active = 0  AND completed = 0 AND delivery_id=?', delivery.id).count == 0

            logger.debug '==================================== RE ALLOCATION - ALLOCATION COUNT ===================================='


              #delivery.allocateWithNearestDriverWithIgnoreDrivers(delivery)
              delivery.go_to_next_driver
            end
          else
            # delivery.allocateWithNearestDriverWithIgnoreDrivers(delivery)
            delivery.go_to_next_driver
          end

      else

        logger.debug '==================================== RE ALLOCATION - FIRST ELSE ===================================='

        if delivery.manual == 1
          delivery.createAllocation
        else

          logger.debug '==================================== RE ALLOCATION - SECOND ELSE ===================================='

          @locations = DriverAllocation.where('(active != 1 AND active != 3)   AND completed = 0 AND delivery_id=?', delivery.id)

          if @locations.length > 0


            if DriverAllocation.where('active = 0  AND completed = 0 AND delivery_id=?', delivery.id).count == 0



              # delivery.allocateWithNearestDriverWithIgnoreDrivers(delivery)
              delivery.go_to_next_driver
            end
          else





            # delivery.allocateWithNearestDriverWithIgnoreDrivers(delivery)
            delivery.go_to_next_driver
          end
        end
      end
    end
  end

  def self.allocate_to_driver(dId)
    delivery = Delivery.find(dId)
    logger.debug "DELIVERY ID: #{delivery}"
    @locations = DriverAllocation.where('(active != 1 AND active != 3)   AND completed = 0 AND delivery_id=?', delivery.id)

    if @locations.length > 0
      if DriverAllocation.where('active = 0  AND completed = 0 AND delivery_id=?', delivery.id).count == 0
        driverLocations = DriverLocation.all_drivers(delivery.delivery_vehicle.drivers.collect(&:id))
        newDriverLocation = DriverLocation.getNearestDriverWithIgnore(delivery.from_lat, delivery.from_lon, DriverAllocation.notAvailableIdList(delivery.id), driverLocations.collect(&:id))

        if newDriverLocation
          Delivery.newAllocation(newDriverLocation, delivery.id)
        end

      end
    else
      driverLocations = DriverLocation.all_drivers(delivery.delivery_vehicle.drivers.collect(&:id))
      newDriverLocation = DriverLocation.getNearestDriverWithIgnore(delivery.from_lat, delivery.from_lon, DriverAllocation.notAvailableIdList(delivery.id), driverLocations.collect(&:id))
      if newDriverLocation
        Delivery.newAllocation(newDriverLocation, delivery.id)
      end
    end
  end


  def self.resetAllocations
    DriverAllocation.where('active=0 AND completed=0').each do |allocation|
      @delivery = Delivery.find(allocation.delivery_id)
      logger.debug "SECONDS GAP: #{@delivery.gapAsSeconds}"

      if @delivery.gapAsSeconds > 299
        allocation.active = -1
        allocation.save
        @location = DriverLocation.driverOnHold(allocation.driver_id)
        if @location
          logger.debug "STATUS ID: #{@location.driver_status_id}"
          @location.driver_status_id = 1
          @location.save
        end


        # @tempAllocation = TempAllocation.new
        # @tempAllocation.driver_id = allocation.driver_id
        # @tempAllocation.delivery_id = allocation.delivery_id
        # @tempAllocation.active = -1
        # @tempAllocation.save


      end
    end




  end

  def inactiveDelivery(driverId)
    DriverAllocation.where('driver_id =? AND delivery_id=? AND active=0 AND completed=0', driverId, self.id).each do |allocation|
      if self.gapAsSeconds > 299
        @location = DriverLocation.driverOnHold(allocation.driver_id)
        allocation.active = -1
        allocation.save
        if @location
          logger.debug "STATUS ID: #{@location.driver_status_id}"
          @location.driver_status_id = 1
          @location.save
        end
      end
    end

    # TempAllocation.where('driver_id =? AND delivery_id=? AND active=0 AND completed=0', driverId, self.id).each do |allocation|
    #   if self.gapAsSeconds > 299
    #     @location = DriverLocation.driverOnHold(allocation.driver_id)
    #     allocation.active = -1
    #     allocation.save
    #   end
    # end

  end

  def self.newAllocation(driverLocation, delivery_id)
    if DriverAllocation.where('active = 0  AND completed = 0 AND delivery_id=?', delivery_id).count == 0
      driverLocation.driver_status_id = 2
      driverLocation.save

      logger.debug "LOCATION DEVICE TYPE: #{driverLocation.driver_status_id }"

      @delivery = Delivery.find(delivery_id)
      @delivery.setUpdatedTime
      @delivery.save

      # @driverAllocation = DriverAllocation.new
      # @driverAllocation.driver_id = driverLocation.driver_id
      # @driverAllocation.delivery_id = delivery_id

      @driverAllocation = DriverAllocation.new(delivery_id: delivery_id, driver_id: driverLocation.driver_id)
      @driverAllocation.active = 0
      @driverAllocation.attempt_count += 1
      @driverAllocation.save


      # @todo assigning allocation for the temp_allocations table
      # @tempAllocation = TempAllocation.new
      # @tempAllocation.driver_id = driverLocation.driver_id
      # @tempAllocation.delivery_id = delivery_id
      # @tempAllocation.active = 0
      # @tempAllocation.save



      logger.debug "NEW ALLOCATION METHOD  AND DELIVERY ID #{driverLocation.driver_id}"



      @delivery.sendPushNotification(@driverAllocation.driver_id, "New delivery received for a #{@delivery.delivery_vehicle.name}")




      DeliveryWorker.perform_at(10.minutes.from_now, {'driver_allocation_id' => @driverAllocation.id,
                                                      'delivery_id' => delivery_id})
    end

    #DeliveryWorker.perform_in(2.minutes, {'locationId' => driverLocation.id, 'deliveryId' => delivery_id})
    #Delivery.delay_for(1.minutes, :retry => false).checkDriverAction(driverLocation.id, delivery_id)
  end

  def getAcceptedDriverAllocation
    allocations = DriverAllocation.where('delivery_id =? AND active = 1', self.id)
    if allocations.length > 0
      return allocations[0]
    else
      return nil
    end
  end



  def getVehicle
    return DeliveryVehicle.find(self.delivery_vehicle_id)
  end

  def sendPushNotification(driver, message)
    APNS.host = 'gateway.push.apple.com'
    APNS.pem = File.join(Rails.root, 'storage', 'certificates',  'prod_driver.pem')
    APNS.port = 2195
    APNS.pass = 'gustavo'

    GCM.key = "AIzaSyBSkLjLbIuN-yzkAXxK6fTg41NmyYqaNzs"

    iosPushDevices = []
    androidPushDevices = []

    DriverDevice.where('driver_id =?', driver).each do |user_device|
      if user_device.token
        if user_device.device_type=='IPHONE'

          iosPushDevices << APNS::Notification.new(user_device.token, :sound => 'chime', :alert => message, :other => {:delivery_id => self.id, :status_id => self.delivery_status_id})

#          iosPushDevices << APNS::Notification.new(user_device.token, :alert => message, :other => {:delivery_id => self.id, :status_id => self.delivery_status_id})

        else
          androidPushDevices << GCM::Notification.new(user_device.token, {:message => message, :delivery_id => self.id})
        end
      end
    end

    if iosPushDevices.length > 0
      APNS.send_notifications(iosPushDevices)
    end

    if androidPushDevices.length > 0
      GCM.send_notifications(androidPushDevices)
    end
  end

  def sendPushForUser(message)
    APNS.host = 'gateway.push.apple.com'
    APNS.pem = File.join(Rails.root, 'storage', 'certificates', 'prod_driver.pem')
    APNS.pass = 'gustavo'

    GCM.key = "AIzaSyBRNUoP_4MLUVsNuudjeDHsA0_P2yHpujo"

    iosPushDevices = []
    androidPushDevices = []
    UserDevice.where('user_id =?', self.user_id).each do |user_device|
      if user_device.token
        if user_device.device_type == 'IPHONE'
          iosPushDevices << APNS::Notification.new(user_device.token, :sound => 'chime', :alert => message, :other => {:delivery_id => self.id, :status_id => self.delivery_status_id})

          #iosPushDevices << APNS::Notification.new(user_device.token, :alert => message, :other => {:delivery_id => self.id, :status_id => self.delivery_status_id})
        else
          androidPushDevices << GCM::Notification.new(user_device.token, {:message => message, :delivery_id => self.id, :status_id => self.delivery_status_id})
        end
      end
    end

    if iosPushDevices.length > 0
      APNS.send_notifications(iosPushDevices)
    end

    if androidPushDevices.length > 0
      GCM.send_notifications(androidPushDevices)
    end
  end

  def gapAsSeconds
    if self.status_updated_at.nil?
      return (Time.parse(DateTime.now.to_s) - Time.parse(self.created_at.to_s))
    else
      return (Time.parse(DateTime.now.to_s) - Time.parse(self.status_updated_at.to_s))
    end
  end


  def setUpdatedTime
    self.status_updated_at = Time.now
  end


  def setDeliveryDateTime
    self.delivery_date = Time.now
  end


  def setCancellation
    if self.delivery_status_id != 6
      self.update_columns(delivery_status_id: 6, canceled_at: Time.current)

      #Rails.logger.info "DELIVERY #{self.id} IS UPDATED"

      allocation = DriverAllocation.where('delivery_id=?', self.id).last()

      # tempAllocation = TempAllocation.where('delivery_id=?', self.id).last()

      if allocation.present? #&& tempAllocation.present?
        #Rails.logger.info "DRIVER LOCATION #{allocation.driver_id}"

        allocation.active = -2
        allocation.updated_at = Time.current
        allocation.attempt_count += 1
        allocation.save!


        location = DriverLocation.where('driver_id=?',allocation.driver_id).last()

        if location.present?

          Rails.logger.info "DRIVER LOCATION #{location.driver_id}"

          location.driver_status_id = 1
          location.updated_at = Time.current
          location.save!


          self.sendPushNotification(location.driver_id, "The delivery ID #{self.id} has been Canceled")
        end
        #Rails.logger.info "AFTER PUSH IS SENT TO DRIVER"
      end

      self.sendPushForUser("The delivery ID #{self.id} has been Canceled")
      #Rails.logger.info "AFTER PUSH IS SENT TO THE USER"
    end
  end


  def sendCancellationEmail
    Rails.logger.debug "EMAIL SENT INITIALISED FOR DELIVERY ID: #{self.id}"
    DeliveryMailer.cancellation(self).deliver_later
  end

  # @todo uncomment static way of setting value for commission
  def setDriversCommission
    self.update_columns(drivers_commission: 0)
    # self.update_columns(drivers_commission: (self.cost * 80) / 100)
  end



  def getStringDeliveryStatus


    if self.delivery_status_id == 0
        return 'Pending'
    else
      if self.delivery_status.id == 1
        if self.manual != 1
          return 'Driver Allocating'
        else
          return 'Driver Allocated'
        end
      end
    end
    return self.delivery_status.status

  end




  # def self.headers
  #     {"last name" => "l_name",
  #      "first name" => "f_name"}
  # end
  # def self.import(file)
  #     CSV.parse(self.parse_headers(file), headers: true) do |row|
  #         User.create! row.to_hash
  #     end
  # end
  # def self.parse_headers (file)
  #   File.open(file) { |f|
  #                 first_line = f.readline
  #                 self.headers.each { |k,v| first_line[k] &&= v }
  #                 first_line + f.read }
  # end


  def self.to_csv
    attributes = %w{id company_name company_user_name  from to vehicle_name pod_datetime recipient_name delivery_cost delivery_state}

    CSV.generate(headers: true) do |csv|
      
      csv << attributes

      all.each do |delivery|
        csv << attributes.map{ |attr| delivery.send(attr) }
      end
    end
  end


  def company_name
    self.user.organisation_name
  end

  def company_user_name
    self.user.name
  end

  def from
    self.from_location
  end


  def to
    self.to_location
  end

  def vehicle_name
    self.delivery_vehicle.name
  end

  def pod_datetime
    self.signature_updated_at
  end


  def recipient_name
    self.delivery_contact
  end


  def delivery_cost
    self.cost
  end


  def delivery_state
    self.delivery_status.status
  end


end
