module ApplicationHelper
  
  def flash_class(level)
    case level
    when :notice then ""
    when :success then "success"
    when :error then "error"
    when :alert then "alert"
    end
  end
    
  def current_user
    return User.find_by_id(session[:user_id])    
  end
  
  
  def days_ago(past_date)
    num_days = Date.today - past_date
    str = "Today"
    if num_days == 1 
      str = "yesterday"
    elsif num_days > 1
      str = "#{num_days.to_i} days ago"
    end
    str
  end
  
end
