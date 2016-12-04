class DriverReference < ActiveRecord::Base
  validates :name, presence: true, :on => :update
  validates :address, presence: true, :on => :update
  validates :how_long_know, presence: true, :on => :update
  validates :relationship, presence: true, :on => :update
  validates :organization, presence: true, :on => :update
  validates :postcode, presence: true, :on => :update
  validates :email, presence: true, :on => :update
  validates :telephone, presence: true, :on => :update
  validates :is_contacted_prior_to_interview, presence: true, :on => :update
end
