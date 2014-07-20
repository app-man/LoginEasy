class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :is_user_logged_in
  protect_from_forgery with: :exception
private
def is_user_logged_in
	@isUserLoggedIn = authenticate_user
end  
protected 
def authenticate_user
  if session[:user_id]
     # set current user object to @current_user object variable
  	# render "authenticate_user true"     
    @current_user = User.find session[:user_id] 
    return true	
  else
    # redirect_to(:controller => 'sessions', :action => 'login')
    return false
  end
end
def save_login_state
  if session[:user_id]
    redirect_to(:controller => 'sessions', :action => 'home')
    return false
  else
    return true
  end
end  

end
