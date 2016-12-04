class Driver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :employments
  has_many :employment_gaps
  has_many :driver_references
  belongs_to :vehicle_type
  belongs_to :delivery_vehicle

  accepts_nested_attributes_for :employments
  accepts_nested_attributes_for :employment_gaps
  accepts_nested_attributes_for :driver_references

  attr_accessor :validationType

  has_attached_file :avatar,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/avatar/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/avatar/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/avatar/:id/:style/:basename.:extension"

  validates_attachment :avatar,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :photo_of_self,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/photo_of_self/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/photo_of_self/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/photo_of_self/:id/:style/:basename.:extension"

  validates_attachment :photo_of_self,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :license_paper,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/license_paper/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/license_paper/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/license_paper/:id/:style/:basename.:extension"

  validates_attachment :license_paper,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :license_photo_id,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/license_photo_id/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/license_photo_id/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/license_photo_id/:id/:style/:basename.:extension"

  validates_attachment :license_photo_id,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :utility_bill,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/utility_bill/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/utility_bill/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/utility_bill/:id/:style/:basename.:extension"

  validates_attachment :utility_bill,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :passport,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/passport/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/passport/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/passport/:id/:style/:basename.:extension"

  validates_attachment :passport,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :bank_details,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/bank_details/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/bank_details/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/bank_details/:id/:style/:basename.:extension"

  validates_attachment :bank_details,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :national_insurance,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/national_insurance/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/national_insurance/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/national_insurance/:id/:style/:basename.:extension"

  validates_attachment :national_insurance,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :git_insurance,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/git_insurance/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/git_insurance/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/git_insurance/:id/:style/:basename.:extension"

  validates_attachment :git_insurance,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :emergency_document,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/emergency_document/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/emergency_document/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/emergency_document/:id/:style/:basename.:extension"

  validates_attachment :emergency_document,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :uniform_info,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/uniform_info/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/uniform_info/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/uniform_info/:id/:style/:basename.:extension"

  validates_attachment :uniform_info,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :vehicle_insurance_certificate,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_insurance_certificate/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_insurance_certificate/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_insurance_certificate/:id/:style/:basename.:extension"

  validates_attachment :vehicle_insurance_certificate,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?


  has_attached_file :vehicle_registration_document,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_registration_document/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_registration_document/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_registration_document/:id/:style/:basename.:extension"

  validates_attachment :vehicle_registration_document,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :vehicle_m_o_t_certificate,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_m_o_t_certificate/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_m_o_t_certificate/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_m_o_t_certificate/:id/:style/:basename.:extension"

  validates_attachment :vehicle_m_o_t_certificate,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :vehicle_rental_agreement,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_rental_agreement/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_rental_agreement/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_rental_agreement/:id/:style/:basename.:extension"

  validates_attachment :vehicle_rental_agreement,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :vehicle_photo,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_photo/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_photo/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_photo/:id/:style/:basename.:extension"

  validates_attachment :vehicle_photo,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?

  has_attached_file :vehicle_road_tax,
                    :styles => { :thumb => "400x400#"},
                    :default_url => "/assets/drivers/vehicle_road_tax/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/drivers/vehicle_road_tax/:id/:style/:basename.:extension",
                    :url => "/assets/drivers/vehicle_road_tax/:id/:style/:basename.:extension"

  validates_attachment :vehicle_road_tax,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }, if: :avatar_image_exist?





  before_create :account_create_session_token
  before_save :ensure_authentication_token

  after_create :createBlankData

  validate :checkCurrentDeliveryStatus, :on => :update

  validates :no_of_absent_dates, presence: true, :on => :update, if: lambda {  validationType ==11 || !no_of_absent_dates.nil? }
  validates :absent_desc, presence: true, :on => :update, if: lambda {  validationType ==11 || !absent_desc.nil? }

  validates :is_convictions_unspent_under_rehabilitation, presence: true, :on => :update
  validates :is_criminal_offence, presence: true, :on => :update

  validates :is_license_valid_in_uk, presence: true, :on => :update
  validates :license_no, :presence => true, :on => :update, if: lambda {  validationType ==11 || !license_no.nil? }
  validates :is_endorsements_on_license, presence: true, :on => :update
  validates :is_blameworthy_accidents, presence: true, :on => :update

  validates :abt_position, presence: true, :on => :update, if: lambda {  validationType ==11 || !abt_position.nil? }
  validates :declaration_agreement, presence: true, :on => :update, if: lambda {  validationType ==11 || !declaration_agreement.nil? }
  validate :checkDeclarationAgreement, :on => :update, if: lambda {  validationType ==11 || validationType ==11 }

  validates :date_of_birth, presence: true, :on => :update, if: lambda {  validationType ==11 || validationType ==10 }


  scope :authenticate, ->(email) {
    where('email = :email',
          email: email).limit(1)
  }

  scope :login, ->(email, password) {
    where('email = :email AND session_token = :password',
          email: email, password: Digest::SHA1.hexdigest(password)).limit(1)
  }

  def saveDriving_license(params)
    self.update(params)
  end

  def validationHealth
    if self.no_of_absent_dates.length == 0
      errors[:no_of_absent_dates] << 'You need to agree'

    end
    if !self.absent_desc
      errors[:absent_desc] << 'You need to agree1'

    end

  end

  def createBlankData
    for i in 0..5
      @dr = Employment.new
      if i ==5
        @dr.is_present = 1
      end
      @dr.driver_id = self.id
      @dr.save

      if i < 5
        @gap = EmploymentGap.new
        @gap.driver_id = self.id
        @gap.save
      end

      if i < 2
        @ref = DriverReference.new
        @ref.driver_id = self.id
        @ref.save
      end
    end
  end

  def checkDeclarationAgreement
    if self.declaration_agreement != 1
      errors[:base] << 'You need to agree'
    end
  end

  def validateHealth
    if !self.no_of_absent_dates
      errors[:base] << 'You need to fill fill absent days.'
    end
  end

  def checkCurrentDeliveryStatus
    if self.is_delete == 1
      @dLocation = self.driverStatus
      if @dLocation
        if @dLocation.driver_status_id == 2 || @dLocation.driver_status_id == 3
          errors[:base] << "Already allocated to delivery. Please try again later"
        end
      end
    end

  end

  def account_create_session_token
    # self.token = Driver.encrypt_sha2(self.email)
    self.session_token =  Digest::SHA1.hexdigest(self.password)
  end

  def self.encrypt_sha2(text)
    Digest::SHA2.hexdigest text
  end

  def setAccountStatus(status)
    self.status = status
  end

  def name
    return "#{self.first_name} #{self.surname}"
  end

  def age
    return ""
  end

  def updateDriverDevice(token, type)

    handsets = DriverDevice.where('driver_id =? AND device_type=?', self.id, type)

    if handsets.length == 0
      handset                   =  DriverDevice.new()
      handset.token             = token
      handset.device_type       = type
      handset.driver_id           = self.id
      handset.save
      Rails.logger.info("CREATING DEVICE TOKEN FOR #{ self.id }")
    else
      Rails.logger.info("UPDATING DEVICE TOKEN FOR #{ self.id }")
      handset = handsets[0]
      handset.driver_id           = self.id
      handset.token             = token
      handset.save
    end
  end

  def getJSON(options = {})
    obj = {
      user_id: self.id,
      name: self.name,
      email: self.email,
      token: self.token,
      avatar: self.avatar.url(:thumb),
      title: self.title,
      first_name: self.first_name,
      surname: self.surname,
      middle_name: self.middle_name,
      mobile_no: self.mobile_no,
      land_no: self.land_no,
      gender: self.gender
    }
    return obj
  end

  def avatar_url
    return "http://staging.iwadbackoffice.com#{self.avatar.url(:thumb)}"
  end

  def getJSONWithoutToken(options = {})
    obj ={
        user_id: self.id,
        name: self.name,
        email: self.email,
    }
    return obj
  end

  def avatar_image_exist?
    !self.avatar.nil?
  end

  def completedDeliveries
    return Delivery.where('driver_id=? AND delivery_status_id=5', self.id).order('signature_updated_at DESC')
  end

  def manualAllocation
    if DriverAllocation.where('active=1 AND driver_id=?', self.id).count == 0
      @allocations =  DriverAllocation.where('active=3 AND driver_id=?', self.id)

      logger.info "Processing the request... from MODEL"

      if @allocations.length > 0
        if self.isAvailable
          @location = self.isAvailable
          @location.driver_status_id = 3
          @location.save

          logger.info "DELIVERY information from MODEL #{@location}"

          @allocation = @allocations[0]
          @allocation.active = 1
          @allocation.save

          logger.info "DELIVERY information from MODEL #{@allocation}"

          @delivery = Delivery.find(@allocation.delivery_id)

          logger.info "DELIVERY information from MODEL #{@delivery}"

          @delivery.delivery_status_id 	= 2
          @delivery.save

          @delivery.sendPushNotification(@delivery.driver_id, "New delivery received for a #{@delivery.delivery_vehicle.name}")

          logger.info "Ending the Process of the request... from MODEL"

          return true
        else
          return false
        end

      else
        return false
      end
    end

  end

  def getTotalCostForCompletedDeliveries
    return self.completedDeliveries.sum(:cost)
  end

  def getCommission
    return (self.getTotalCostForCompletedDeliveries * 80/ 100)
  end

  def removeDevices(token, type)
    DriverDevice.destroy_all(:token => token , :device_type => type, driver_id: self.id)
  end

  def isAvailable
    @driverLocations = DriverLocation.where('driver_id =? AND driver_status_id=1',self.id)
    if @driverLocations.length != 0
      return @driverLocations[0]
    else
      return nil
    end
  end

  def driverStatus
    @driverLocations = DriverLocation.where('driver_id =?',self.id)
    if @driverLocations.length != 0
      return @driverLocations[0]
    else
      return nil
    end
  end

  def getTotalCostForCompletedDeliveriesMonthly
    return Delivery.where('driver_id=? AND delivery_status_id=5 AND created_at > ? AND created_at < ?', self.id,  Date.current.beginning_of_month, Date.current.end_of_month).sum(:drivers_commission)
  end

  def getTotalCostForCompletedDeliveriesToday
    return Delivery.where('driver_id=? AND delivery_status_id=5 AND created_at > ? AND created_at < ?', self.id,  Date.current.beginning_of_day, Date.current.end_of_day).sum(:drivers_commission)
  end

  def getTotalCostForCompletedDeliveryCountMonthly
    return Delivery.where('driver_id=? AND delivery_status_id=5 AND created_at > ? AND created_at < ?', self.id,  Date.current.beginning_of_month, Date.current.end_of_month).count
  end

  def getTotalCostForCompletedDeliveryCountToday
    return Delivery.where('driver_id=? AND delivery_status_id=5 AND created_at > ? AND created_at < ?', self.id,  Date.current.beginning_of_day, Date.current.end_of_day).count
  end

  def getCommissionMonthly
    return (self.getTotalCostForCompletedDeliveriesMonthly * 80/ 100)
  end

  def getCommissionToday
    return (self.getTotalCostForCompletedDeliveriesToday * 80/ 100)
  end



  def updatePassword(password)
    self.password = password
    self.password_confirmation = password
    self.session_token =  Digest::SHA1.hexdigest(self.password)
    self.save
  end

  def removeLocations
    DriverLocation.destroy_all(:driver_id => self.id)
  end

  def goOffline
    DriverLocation.where('driver_id = ?', self.id).update_all(driver_status_id: 4)
  end

  def goOnline
    DriverLocation.where('driver_id = ?', self.id).update_all(driver_status_id: 1)
  end

  def lat
    @driverLocations = DriverLocation.where('driver_id =?',self.id)
    if @driverLocations.length != 0
      return @driverLocations[0].lat
    else
      return nil
    end
  end

  def lon
    @driverLocations = DriverLocation.where('driver_id =?',self.id)
    if @driverLocations.length != 0
      return @driverLocations[0].lon
    else
      return nil
    end
  end


  # Set time_zone field based on user input
  def set_time_zone_to_driver(time_zone)
    update_attributes time_zone: time_zone
  end


  def ensure_authentication_token
    self.token ||= new_token!
  end

  def new_token!
    SecureRandom.hex(36).tap do |random_token|
      update_attributes token: random_token
      Rails.logger.info("Set new token for user #{ id }")
    end
  end
end
