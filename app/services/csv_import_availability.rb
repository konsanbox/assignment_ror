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
      start = Time.zone.parse(row['Available at']).getlocal.strftime("%H:%M")
      stop = Time.zone.parse(row['Available until']).getlocal.strftime("%H:%M")
      # TODO improve this - some cases may require changing day of the week as well - (GMT-09:00) America/Yakutat,Monday, 8:00PM,11:00PM?

      coach.availabilities.create!(week_day: row['Day of Week'], start: start, stop: stop)
    end

    Time.zone = initial_zone
  end

  private
  attr_reader :filepath
end
