class Coach < ApplicationRecord
  has_many :bookings
  has_many :availabilities

  default_scope { order(name: :asc) }

  validates :name, presence: true

  def available?(start_datetime)
    return false if start_datetime < DateTime.current
    return false if bookings.where(starts_at: start_datetime.to_datetime).any?

    same_day_availabilities = availabilities.where(week_day: start_datetime.wday_name)
    return false unless same_day_availabilities.any? { |availability| availability.include?(start_datetime) }
    
    true
  end
end
