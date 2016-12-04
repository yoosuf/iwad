class AdminNotification < ActiveRecord::Base


  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
  validates :email,                 presence: true, on: :create, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
end
