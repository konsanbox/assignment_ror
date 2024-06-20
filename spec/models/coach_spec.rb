require 'rails_helper'

describe Coach do
  let(:coach) { create(:coach) }
  let(:user) { create(:user) }
  let(:selected_slot) { 1.day.from_now.noon }

  let!(:availability) do 
    coach.availabilities.create!(
      week_day: selected_slot.wday_name,
      start: '12:00',
      stop: '14:00'
    )
  end

  describe '#available?(start_datetime)' do
    it 'not available in the past' do
      expect(coach.available?(1.day.ago)).to eq(false)
    end

    it 'available if not booked' do
      expect(coach.available?(selected_slot)).to eq(true)
    end

    it 'not available if already booked' do
      Booking.create!(user: user, coach: coach, starts_at: selected_slot)
      expect(coach.available?(selected_slot)).to eq(false)
    end

    it 'available if in availability' do
      expect(coach.available?(selected_slot)).to eq(true)
    end

    it 'not available outside of availability (different hours)' do
      expect(coach.available?(selected_slot + 5.hours)).to eq(false)
    end

    it 'not available outside of availability (different day)' do
      expect(coach.available?(selected_slot + 1.day)).to eq(false)
    end
  end
end
