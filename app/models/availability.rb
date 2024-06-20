class Availability < ApplicationRecord
  belongs_to :coach

  SESSION_LENGTH_MINUTES = 30

  validates :week_day, inclusion: { in: Date::DAYNAMES,
    message: "%{value} is not a valid day name" }
  validates :start, :stop, presence: true
  validates :start, :stop, format: {with: /(2[0-3]|[01]?[0-9]):([0-5]?[0-9])\z/}

  def include?(start_datetime)
    return false unless start_datetime.wday == wday
    return false unless start_datetime >= start.to_datetime.change(day: start_datetime.day)
    return false unless start_datetime <= (stop.to_datetime.change(day: start_datetime.day, year: start_datetime.year) - SESSION_LENGTH_MINUTES.minutes)

    true
  end

  def wday
    Date::DAYNAMES.index(week_day)
  end
end
