module TodosHelper
  
  def read_priority(priority)
    case priority
    when 0
      "Low"
    when 1
      "Medium"
    when 2
      "High"
    end
  end

  def read_status(status)
    status == true ? "Done" : "To Do"
  end
  
  def bg_status(status)
    "bg-card-done" if status == true
  end

  def time_ago(time)
    seconds = Time.now.to_i - time.to_i
    if seconds / 60 >= 1
      minutes = seconds / 60
      if minutes / 60 >= 1
        hours = minutes / 60
        if hours / 60 >= 1
          days = hours / 24
          return (days == 1 ? "1 day" : "#{days} days") + "#{hours} h ago"
        else
          return "#{hours} h #{minutes % 60} min ago"
        end
      else
        return "#{minutes} min #{seconds % 60} sec ago"
      end
    else
    return "#{seconds} sec ago"
    end
  end

  def bg_priority(priority)
    case priority
    when 0
      "bg-prio-low"
    when 1
      "bg-prio-medium"
    when 2
      "bg-prio-high"
    end
  end

  def active_sort_link(sort)
    "active" if sort == params[:sort]
  end

end
