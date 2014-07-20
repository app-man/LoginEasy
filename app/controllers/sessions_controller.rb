class SessionsController < ApplicationController
before_filter :authenticate_user, :only => [:home, :profile, :setting]
before_filter :save_login_state, :only => [:login, :login_attempt]	
	def login
	end
	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
			redirect_to(:action => 'home')
		else
			flash.keep[:notice] = "Invalid Username or Password"
			flash.keep[:color]= "invalid"
			redirect_to(:action => 'index',error_message: "Invalid Username or Password",:locals => {:errorMessage => "yes"})
		end
  end
  def home
  end

  def profile
    @user = User.find(session[:user_id])
  end

  def setting
  end

  def passreset

  end  
  def contactus
  end
  def passreset_attempt
  	if params[:submit_button]
  		# render plain: "returned from the password reset form"
  		render "home"
  	else
  		# render plain: "cancel pressed"
  		render "home"
  	end
  end
def logout
  session[:user_id] = nil
  redirect_to :action => 'index'
end  
end
