class NotificationsController < ApplicationController
  
  
  def index
    
    
    
    APNS.host = 'gateway.push.apple.com'
    APNS.port = 2195
    APNS.pem = File.join(Rails.root, 'storage', 'certificates', 'prod_driver.pem')
    APNS.pass = 'gustavo'
    #
    iosPushDevices= []
    #
    #
    # iosPushDevices << APNS::Notification.new('ecdf3158346b4040eacf22fd0ba2db91ea8a86820f17f3179f8cf2e2883fc446', :alert => 'hello, i am en route to delivary', :other => {:delivery_id => "31", :status_id => "5"})
    
    # iosPushDevices << APNS::Notification.new("92186f0a800f3028931642c2b3e24c68665ea1394e57315cce203697f8d85d0f", :alert => "Test", :other => {:delivery_id => "2", :status_id => "5"})
    
    
    # if APNS.send_notifications(iosPushDevices)
      # render :json => {:success => :true}
    # end
      
    APNS.send_notification("92186f0a800f3028931642c2b3e24c68665ea1394e57315cce203697f8d85d0f", 'Hello iPhone!' )

    
    
    # APNS.send_notification("92186f0a800f3028931642c2b3e24c68665ea1394e57315cce203697f8d85d0f", :alert => 'Hello iPhone!', :badge => 1, :sound => 'default')

    
    
    # render :json => {:success => :true}
    
    
    # APNS.pem = File.join(Rails.root, 'storage', 'certificates',  'prod_driver.pem')
    # APNS.pass = 'gustavo'
    # GCM.key = "AIzaSyBSkLjLbIuN-yzkAXxK6fTg41NmyYqaNzs"

    # iosPushDevices = []
    # androidPushDevices = []

    # DriverDevice.where('driver_id =?', driver).each do |user_device|
      # if user_device.token
        # if user_device.device_type=='IPHONE'
          # iosPushDevices << APNS::Notification.new(user_device.token, :alert => message, :other => {:delivery_id => self.id, :status_id => self.delivery_status_id})
          
          
          # iosPushDevices << APNS::Notification.new("92186f0a800f3028931642c2b3e24c68665ea1394e57315cce203697f8d85d0f", :alert => "Test", :other => {:delivery_id => "2", :status_id => "5"})
          
          
          
        # else
          # androidPushDevices << GCM::Notification.new(user_device.token, {:message => message, :delivery_id => self.id})
        # end
      # end
    # end

    # if iosPushDevices.length > 0
      # APNS.send_notifications(iosPushDevices)
    # end

    # if androidPushDevices.length > 0
      # GCM.send_notifications(androidPushDevices)
    # end
    
    
  end
end
