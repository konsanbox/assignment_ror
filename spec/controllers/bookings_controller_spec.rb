require 'rails_helper'

describe BookingsController do
  render_views

  let!(:user) { create(:user) }
  let!(:coach) { create(:coach) }

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "handles errors on create new booking" do
    post :create, :params => { coach_id: coach.id, starts_at: "12:00" }
    expect(response).to redirect_to("/booking/new")
    expect(flash.alert).to eq("Slot unavailable")
  end

  it "creates new booking" do
    selected_start = 1.year.from_now.noon
    coach.availabilities.create!(week_day: selected_start.wday_name, start: '01:00', stop: '23:00')

    post :create, :params => { coach_id: coach.id, starts_at: selected_start }
    expect(response).to redirect_to("/")
    expect(flash.notice).to eq("Booking created")
    expect(Booking.count).to eq(1)
  end

  it "cancels booking" do
    selected_start = 1.year.from_now.noon
    coach.availabilities.create!(week_day: selected_start.wday_name, start: '01:00', stop: '23:00')
    booking = Booking.create(starts_at: 1.year.from_now.noon, coach: coach, user: user)

    delete :destroy, :params => { booking_id: booking.id }
    expect(response).to redirect_to("/")
    expect(flash.notice).to eq("Booking canceled")
    expect(Booking.count).to eq(0)
  end
end
