class UsersController < ApplicationController
	before_filter :authenticate_user, :except => [:new, :create]
	def new
		if is_user_logged_in			
			@user = User.find(session[:user_id])
		else 
			@user = User.new
		end
	end
	def create
  		# render plain: params[:user].inspect
  		if params[:cancel_button]
  			redirect_to(:action => 'index',:controller => 'sessions')
  		else
  			if is_user_logged_in
  				@user = User.find(session[:user_id])
			# TODO
			else
				@user = User.new(user_params)		
				if @user.save
					flash[:notice] = "You signed up successfully"
					flash[:color]= "valid"
					redirect_to(:action => 'index',success_message: "You signed up successfully. Please login.",:controller => 'sessions')
				else
					flash[:notice] = "Form is invalid"
					flash[:color]= "invalid"
					# @error_message = "Username or Password exists.Please retry with all the fields."
					redirect_to(:action => 'new',error_message: @user.errors.full_messages,:controller => 'users')				
				end
			end
		end		  		
	end
	def launch_update
		redirect_to(:action => 'new',:controller => 'users')
	end
	def show		
		@user = User.find(params[:id])
	end
	def index
		@users = User.search(params[:search_query_user])
	end
  	def destroy
    	@user = User.find(params[:id])
    	@user.destroy
    	flash[:notice] = "Successfully destroyed user."
		redirect_to(:action => 'index',success_message: "Successfully removed the user.",:controller => 'sessions')    	
    	# redirect_to users_url
  	end		
	private
	def user_params
		params.require(:user).permit(:username,:email, :password,:password_confirmation)
	end
	def login_required
		unless current_user
			flash[:error] = 'You must be logged in to view this page.'
			redirect_to new_user_session_path
		end
	end  	
end