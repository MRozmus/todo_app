module TodosHelper
  
  def read_priority(priority)
    case priority
    when 0
      "low"
    when 1
      "medium"
    when 2
      "high"
    end
  end

  def read_status(status)
    status == true ? "done" : "to do"
  end
  
end
