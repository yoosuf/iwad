class DeliveryWorker
  include Sidekiq:: Worker
  sidekiq_options :retry => false

  def perform(args)
    driver_allocation = DriverAllocation.find(args['driver_allocation_id'])

    if driver_allocation.active == -1 && driver_allocation.completed == 0
      delivery = Delivery.find(args['delivery_id'])

      delivery.sendCancellationEmail
    end

    self.process_order_later(args)
  end


  def process_order_later(args)
    # 'locationId' => self.id, 'deliveryId'

    #Delivery.checkDriverAction(args['locationId'], args['deliveryId'])
    delivery_id = args['deliveryId']

    delivery	   = Delivery.find(delivery_id)
    driverLocation = DriverLocation.find(args['locationId'])


    if (driverLocation.driver_status_id == 2)

      newDriverLocation  = DriverLocation.getNearestDriverWithIgnore(delivery.from_lat, delivery.from_lon, DriverAllocation.notAvailableIdList(delivery_id))
      delivery.inactiveDelivery(driverLocation.driver_id)

      if newDriverLocation
        Delivery.newAllocation(newDriverLocation, delivery_id)
      else
        Delivery.allocate_to_driver(delivery_id)
      end
    end
  end

  def send_cancellation_email(delivery_id)
    delivery = Delivery.find(delivery_id)
    DeliveryMailer.cancellation(delivery).deliver_later
  end
end