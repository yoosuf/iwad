class Employment < ActiveRecord::Base
  validates :name, presence: true, :on => :update
  validates :post_title, presence: true, :on => :update
  validates :salary, presence: true, :on => :update
  validates :address, presence: true, :on => :update
  validates :appointment_date, presence: true, :on => :update
  validates :department, presence: true, :on => :update
  validates :notice_period, presence: true, :on => :update
  validates :duty_description, presence: true, :on => :update
end
