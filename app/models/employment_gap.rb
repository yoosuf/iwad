class EmploymentGap < ActiveRecord::Base
  validates :from_date, presence: true, :on => :update
  validates :to_date, presence: true, :on => :update
  validates :reason, presence: true, :on => :update
end
