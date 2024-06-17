class BookingsController < ApplicationController
  def new
    set_selected_coach
    @week_offset = permitted_params[:wo].present? ? params[:wo].to_i : 0
  end

  def index
  end

  def destroy
    Booking.find_by(id: permitted_params[:booking_id]).destroy!
    
    flash.notice = "Booking canceled"
    redirect_to root_path
  end

  def create
    coach = Coach.find_by(id: permitted_params[:coach_id])
    start_datetime = permitted_params[:starts_at].to_datetime

    if coach.available?(start_datetime)
      Booking.find_or_create_by!(user: @current_user, coach: coach, starts_at: start_datetime)
      flash.notice = "Booking created"
      redirect_to root_path
    else
      flash.alert = "Slot unavailable"
      redirect_to new_booking_path
    end
  end

  private

  def set_selected_coach
    @selected_coach = Coach.find_by(id: permitted_params[:c]) || Coach.first
  end

  def permitted_params
    params.permit(:booking_id, :coach_id, :starts_at, :c, :wo)
  end
end
