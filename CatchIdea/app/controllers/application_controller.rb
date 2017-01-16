class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_action :sign_in?

	def sign_in?
		@users = User.all
		if @users.find_by(email: session[:email], password: session[:password]).nil?
			redirect_to(controller: :users, action: :sign_in, id: 0)
		end
	end
	def	admin?
		if (permission == 2)
			true
		else
			false
		end
	end
	def permission
		User.all.find_by(email: session[:email], password: session[:password]).permission
	end
end
