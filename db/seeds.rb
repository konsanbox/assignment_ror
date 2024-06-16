# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "RUNNING DB SEEDS"

CsvImportAvailability.new.call

coach = Coach.first

user = User.find_or_create_by!(name: "User", email: "user@example.com")
other_user = User.find_or_create_by!(name: "Other", email: "other@example.com")

Booking.find_or_create_by!(user: user, coach: coach, starts_at: 1.day.ago.noon)
Booking.find_or_create_by!(user: user, coach: coach, starts_at: 1.day.from_now.noon)
Booking.find_or_create_by!(user: user, coach: coach, starts_at: 1.day.from_now.noon + 3.hours)
Booking.find_or_create_by!(user: other_user, coach: coach, starts_at: 1.day.from_now.noon + 1.hour)

puts "DB SEEDS READY"
