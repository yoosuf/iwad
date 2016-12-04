class Offer < ActiveRecord::Base
  validates :name, presence: true
  validates :start_date, presence: true
  validates :description, presence: true
  validates :end_date, presence: true
  validate :is_valid_start_and_end_date?

  def is_valid_start_and_end_date?
    errors.add(:start_date, ' must be less than End date') if self.start_date >= self.end_date
  end
end
