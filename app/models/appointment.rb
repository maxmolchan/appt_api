class Appointment < ActiveRecord::Base

  attr_accessible :comments, :end_time, :first_name, :last_name, :start_time
  
  
  def self.filter_by_date(s,e)

    if s && e && e > s
      where("start_time >= ? AND end_time <= ?", s.to_datetime, e.to_datetime)
    elsif s
      where("start_time >= ?", s.to_datetime)
    elsif e
      where("start_time <= ?", e.to_datetime)
    else
      all
    end

  end


  def dates_valid?(s,e)

    datetime_now = DateTime.now

    s ?  start_time = s.to_datetime : valid = false
    e ?  end_time = e.to_datetime : valid = false

    if start_time && end_time && start_time < end_time

      if start_time > datetime_now && end_time > datetime_now
        Appointment.select('start_time, end_time').each do |appt|

          if start_time > appt.end_time || end_time < appt.start_time
          valid = true
          else
          valid = false
          break
          end

        end
      
      else
      valid = false
      end

    else
    valid = false
    end

    valid
  end

end
