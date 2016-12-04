class DriverLocation < ActiveRecord::Base
  belongs_to :driver_status, :class_name => "DriverStatus", :foreign_key => "driver_status_id"
  belongs_to :driver, :class_name => "Driver", :foreign_key => "driver_id"

  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lon


  scope :all_drivers, ->(driver_ids) {
    where('driver_id  IN (?) AND driver_status_id != ? AND driver_locations.updated_at > ?',
          driver_ids, 4, DateTime.now.utc - 8.hours)
  }

  scope :drivers_by_vehicle_type, ->(vehicle_type_id) {
    where('drivers.delivery_vehicle_id = ? ', vehicle_type_id).joins(:driver)
  }

  def self.driverAvailable(driver_id)
    @driverLocations = DriverLocation.where('driver_id =? AND driver_status_id=1',driver_id)
    if @driverLocations.length != 0
      @driverLocations[0]
    else
      return nil
    end
  end

  def self.driverOnADelivery(driver_id)
    @driverLocations = DriverLocation.where('driver_id =? AND driver_status_id=3',driver_id)
    if @driverLocations.length != 0
      @driverLocations[0]
    else
      return nil
    end
  end

  def setAsAvailable
    self.driver_status_id = 1
    self.save
  end

  def self.allAvailableDrivers
    return DriverLocation.where('driver_status_id = 1 AND driver_locations.updated_at > ?' , DateTime.now.utc - 8.hours)
  end

  def self.allDrivers
    return DriverLocation.where('driver_status_id != 4 AND driver_locations.updated_at > ?', DateTime.now.utc - 8.hours)
  end

  def self.driverOnHold(driver_id)
    @driverLocations = DriverLocation.where('driver_id =? AND driver_status_id=2',driver_id)
    if @driverLocations.length != 0
      @driverLocations[0]
    else
      return nil
    end
  end

  def self.getNearestDriver(lat, lon)
    puts  " putl call nearset method #{lat}"
    return DriverLocation.getNearestDriverWithIgnore(lat, lon, [0])
  end

  def self.getNearestDriverWithIgnore(lat, lon, ids, available_driver_locations = [])
    # include_driver_locations = []
    # if available_driver_locations.length > 0
    #   include_driver_locations = available_driver_locations.collect(&:id)
    # end

    if ids.length != 0
      results   = DriverLocation.by_distance(:origin => [lat, lon]).where("driver_status_id = 1  AND updated_at > ? AND driver_id not in (#{ids.join(',')}) AND driver_id IN (?)" , DateTime.now.utc - 8.hours, available_driver_locations)
    else
      results   = DriverLocation.by_distance(:origin => [lat, lon]).where('driver_status_id = 1  AND updated_at > ? AND driver_id IN (?)' , DateTime.now.utc - 8.hours, available_driver_locations)
    end

    if results.length != 0
      return results [0]
    else
      return nil
    end
  end

end
