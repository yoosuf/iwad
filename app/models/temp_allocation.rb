class TempAllocation < ActiveRecord::Base

  belongs_to :deliveries, :class_name => "Delivery", :foreign_key => "delivery_id"
  belongs_to :drivers, :class_name => "Driver", :foreign_key => "driver_id"


  def getDelivery
    return Delivery.find(self.delivery_id)
  end

  def getDriver
    return Driver.find(self.driver_id)
  end

  def self.notAvailableIdList(delivery_id)
    return TempAllocation.where('(delivery_id=? AND completed=0 AND (active =-1 or active =0 or active =2  or active=3)) OR active=3 OR active=1', delivery_id).pluck(:driver_id);
  end

  def self.activeList
    return TempAllocation.where('active=3 OR active=1').pluck(:driver_id);
  end

  def self.notAvailableIdListForReject(delivery_id)
    return TempAllocation.where('(delivery_id=? AND completed=0 AND (active =0  or active=3)) OR active=3 OR active=1', delivery_id).pluck(:driver_id);
  end

  def self.no_response(delivery_id)
    return TempAllocation.where('delivery_id=?', delivery_id).pluck(:driver_id)
  end




  def status
    if self.active ==1 and self.completed == 0
      return 'Active'
    elsif self.active == -1 and self.completed == 0
      return 'Auto reject'
    elsif self.active == 2 and self.completed == 0
      return 'Driver reject'
    elsif self.active == 0 and self.completed == 0
      return 'Pending'
    elsif self.active == 0 and self.completed == 1
      return 'Completed'
    elsif self.active == -2 and self.completed == 0
      return 'Canceled'
    end
  end
end
