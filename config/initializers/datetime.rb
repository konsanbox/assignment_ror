class ActiveSupport::TimeWithZone
  def wday_name
    strftime('%A')
  end
end

class DateTime
  def wday_name
    strftime('%A')
  end
end
