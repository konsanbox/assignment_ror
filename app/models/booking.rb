class Booking < ApplicationRecord
  belongs_to :coach
  belongs_to :user

  default_scope { order(starts_at: :asc) }

  scope :past, -> { where('starts_at < ?', DateTime.current) }
  scope :future, -> { where('starts_at >= ?', DateTime.current) }
end
