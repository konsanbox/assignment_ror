require 'csv'

class CsvImportAvailability
  def initialize(filepath = 'db/initial_data.csv')
    @filepath = filepath
  end

  def call
    initial_zone = Time.zone
    
    CSV.foreach(filepath, headers: true) do |row|
      coach = Coach.find_or_create_by!(name: row['Name'])

      Time.zone = row['Timezone'].split(') ').last
      start = Time.zone.parse(row['Available at']).in_time_zone(Rails.configuration.time_zone)
      stop = Time.zone.parse(row['Available until']).in_time_zone(Rails.configuration.time_zone)

      if start.day != stop.day
        coach.availabilities.create!(week_day: row['Day of Week'], start: start.strftime("%H:%M"), stop: '23:59')
        next_day = Date::DAYNAMES[(Date::DAYNAMES.index(row['Day of Week']) + 1) % 7]
        coach.availabilities.create!(week_day: next_day, start: '00:00', stop: stop.strftime("%H:%M")) unless stop.strftime("%H:%M") == '00:00'
      else
        coach.availabilities.create!(week_day: row['Day of Week'], start: start.strftime("%H:%M"), stop: stop.strftime("%H:%M"))
      end
    end

    Time.zone = initial_zone
  end

  private
  attr_reader :filepath
end
