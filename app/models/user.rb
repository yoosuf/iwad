class User < ActiveRecord::Base
  before_create :account_create_session_token
  before_save :ensure_authentication_token



  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
  validates :email,                 presence: true, on: :create, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # validates :date_of_birth,         presence: true, on: :update
  validates :password,              length: {minimum: 6}, on: :create
  validates :country_code, presence: true

  # validates :phone_no, phone: true, on: :create

  # validates :gender     
  # validates :organisation_name
  # validates_uniqueness_of :token

  has_attached_file :avatar,
                    :styles => { :thumb => "400x400#"},
                    :default_url => ":rails_root/public/assets/users/avatar/missing/:style/profile.png",
                    :path => ":rails_root/public/assets/users/avatar/:id/:style/:basename.:extension",
                    :url => "/assets/users/avatar/:id/:style/:basename.:extension"

  validates_attachment :avatar,
                       :content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg"] },
                       :size => { :in => 0..20.megabytes }


  scope :authenticate, ->(email) {
    where('email = :email',
          email: email).limit(1)
  }

  scope :auth_token, -> (token) {
    where('token = :token',
          token: token).limit(1)
  }

  scope :login, ->(email, password) {
    where('email = :email AND password= :password',
          email: email, password: Digest::SHA1.hexdigest(password)).limit(1)
  }



  def account_create_session_token
    # self.token = User.encrypt_sha2(self.email)
    self.password =  Digest::SHA1.hexdigest(self.password)
  end


  def self.encrypt_sha2(text)
    Digest::SHA2.hexdigest text
  end

  def updatePassword(password)
    self.password =  Digest::SHA1.hexdigest(password)
  end

  def getJSON(options = {})
    obj = {
      user_id: self.id,
      name: self.name,
      email: self.email,
      date_of_birth: self.date_of_birth,
      gender: self.gender,
      phone: self.phone_no,
      token: self.token,
    }
    return obj
  end

  def updateUserHandset(token, type)

    handsets = UserDevice.where('user_id =? AND device_type=?', self.id, type)

    if handsets.length == 0
      handset                   =  UserDevice.new()
      handset.token             = token
      handset.device_type       = type
      handset.user_id           = self.id
      handset.save
      Rails.logger.info("CREATING DEVICE TOKEN FOR #{ self.id }")
    else
      Rails.logger.info("UPDATING DEVICE TOKEN FOR #{ self.id }")
      handset = handsets[0]
      handset.user_id           = self.id
      handset.token             = token
      handset.save
    end
  end

  def removeDevices(token, type)
    UserDevice.destroy_all(:token => token , :device_type => type, user_id: self.id)
  end

  def removeSessions(type)
    UserDevice.destroy_all(:device_type => type, user_id: self.id)
  end

  def avatar_url
    return "http://local.iwadbackoffice.com#{self.avatar.url(:thumb)}"
  end

  def completedDeliveries
    return Delivery.where('user_id=? AND delivery_status_id=5', self.id)
  end

  def getTotalCostForCompletedDeliveries
    return self.completedDeliveries.sum(:cost)
  end

  def getCommission
    return (self.getTotalCostForCompletedDeliveries * 80/ 100)
  end

  def decreaseCount
    if self.prepaid_credit_count > 0
      # self.prepaid_credit_count = prepaid_credit_count - 1
      # self.save!

      redeemed = self.prepaid_credit_count - 1
      sql = "UPDATE users SET prepaid_credit_count=#{redeemed} WHERE id= #{self.id}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end



  # @Todo Please use active record method
  # Due to some issue Update isn't working
  def set_prepaid_credits(credits)
    sql = "UPDATE users SET prepaid_credit_count= #{credits} WHERE id= #{self.id}"
    ActiveRecord::Base.connection.execute(sql)
    # self.update_attributes(prepaid_credit_count:  credits)
  end


  # Set time_zone field based on user input
  def set_time_zone_to_user(time_zone)
    if time_zone.nil?
      self.update_attributes(time_zone:  "Europe/London")
    else
      self.update_attributes(time_zone:  time_zone)
    end
  end





  def ensure_authentication_token
    self.token ||= new_token!
  end

  def new_token!
    SecureRandom.hex(36).tap do |random_token|
      update_attributes token: random_token

      # sql = "UPDATE users SET token= #{random_token} WHERE id= #{self.id}"
      # ActiveRecord::Base.connection.execute(sql)

      Rails.logger.info("Set new token for user #{ id }")
    end
  end
end