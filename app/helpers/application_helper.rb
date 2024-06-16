module ApplicationHelper
  def format_datetime(datetime)
    datetime.strftime('%m/%d/%Y %H:%M')
  end

  def format_time(datetime)
    datetime.strftime('%H:%M')
  end

  def format_date(datetime)
    datetime.strftime('%m/%d/%Y')
  end

  def single_slot(start_datetime)
    if @selected_coach.available?(start_datetime)
      css = %w[w-full bg-blue-500 hover:bg-blue-700 text-white font-bold my-1 px-4 rounded]
      button_to format_time(start_datetime),
                { controller: 'bookings', action: 'create', coach_id: @selected_coach.id, starts_at: start_datetime },
                { method: :post, class: css }
    else
      css = %w[w-full bg-blue-200 text-white font-bold my-1 px-4 rounded cursor-not-allowed]
      button_to format_time(start_datetime),
                { controller: 'bookings', action: 'create', coach_id: @selected_coach.id, starts_at: start_datetime },
                { method: :post, class: css, disabled: 'disabled' }
    end
  end

  def daily_slots(start, stop)
    i = start
    slots = []
    while i < stop
      slots << i
      i += 30.minutes
    end
    slots
  end
end
