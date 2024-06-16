class Coach < ApplicationRecord
  has_many :bookings
  has_many :availabilities

  default_scope { order(name: :asc) }

  def available?(start_datetime)
    return false if start_datetime < DateTime.current

    bookings.where(starts_at: start_datetime.to_datetime).empty?
  end
end
