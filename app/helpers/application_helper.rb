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
  
  def current_user_or_admin?(user)
    current_user.is_admin? || current_user == user 
  end
  
  
  def current_filter_state
    if params[:state].nil? || params[:state] != ""
      params[:state].to_s.titleize
    end
  end
  
  def sort_by (column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}
  end
   
  def filter_by (title = nil, input_hash)
    title ||= state.titleize
    output_hash = {}
    output_hash[:state] = input_hash[:state] if !input_hash[:state].nil?
    output_hash[:user_id] = input_hash[:user_id] if !input_hash[:user_id].nil?
    output_hash[:sort] = params[:sort] if !params[:sort].nil?    
    link_to title, output_hash, :remote => true, :title => output_hash[:state].to_s.titleize
  end
   
   def avatar_link_to_profile(u, size=:tiny)    
     
       link_to image_tag( u.avatar.url(size), :title => u.name ), u
      
   
   end
   
   
end
