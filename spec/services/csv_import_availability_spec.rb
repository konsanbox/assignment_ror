require 'rails_helper'

describe CsvImportAvailability do
  describe '#call' do
    it do
      CsvImportAvailability.new.call
      expect(Availability.count).to eq(21)
      expect(Availability.first).to have_attributes(
        week_day: "Monday",
        start: "14:00",
        stop: "22:30",
        coach_id: Coach.find_by(name: "Christy Schumm").id
      )
    end
  end
end
