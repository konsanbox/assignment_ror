require 'rails_helper'

describe Availability do
  let(:availability) do
    Availability.new(
      start: '12:00',
      stop: '15:00',
      week_day: 1.day.from_now.wday_name
    )
  end

  describe '#include?(start_datetime)' do
    it 'false if another weekday' do
      expect(availability.include?(2.days.from_now.noon)).to eq(false)
    end

    context 'same weekday' do
      it 'true if in hourly scope' do
        expect(availability.include?(1.day.from_now.noon)).to eq(true)
      end

      it 'false if after hourly scope' do
        expect(availability.include?(1.day.from_now.noon + 10.hours)).to eq(false)
      end

      it 'false if before hourly scope' do
        expect(availability.include?(1.day.from_now.noon - 2.hours)).to eq(false)
      end
    end
  end
end
