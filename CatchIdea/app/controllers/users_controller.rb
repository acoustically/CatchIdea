class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :sign?, only: [:sign_in, :sign_in_end, :new]
	skip_before_action :sign_in?, only: [:sign_in, :new, :create, :sign_in_end, :sign_out, :destroy]
	layout "layouts/main_layout"
  # GET /users
  # GET /users.json
  def index
		if !admin?
			head 404
		end
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
		render layout: "layouts/sign_layout"
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(sign_up_params)
		@user.permission = 0
    respond_to do |format|
      if @user.save
        format.html { redirect_to url_for({controller: :users, action: :sign_in, id: 0}), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
		if password == session[:password]
			if params[:confirm] == params[:new_password]
   		 	if @user.update(password: params[:new_password])
      		redirect_to action: :sign_out, id: 0
    		else
     			render :edit
				end
			else
				render :edit
			end
		else
			render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
		if admin?
			@user.destroy
			redirect_to users_url
		elsif password == session[:password]
   	 	@user.destroy
			reset_session
			respond_to do |format|
      	format.html { redirect_to '/', notice: 'User was successfully destroyed.' }
      	format.json { head :no_content }
    	end
		else
			render :edit
		end
  end
	def sign_in
		@user = User.new
		render layout: "layouts/sign_layout"
	end
	def sign_in_end
		@users = User.all
		@current_user = @users.find_by(email: email, password: password)
		if !@current_user.nil?
			reset_session
			session[:email] = email
			session[:password] = password
			session[:id] = @current_user.id
			redirect_to url_for(controller: :friends, action: :index, id: session[:id])
		else 
			redirect_to url_for(action: :sign_in, id: 0)
		end
	end
	def sign_out
		reset_session
		redirect_to controller: :users, action: :sign_in, id: 0
	end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :permission)
    end
		def sign_up_params
			params.require(:user).permit(:email, :password, :name)
		end
		def email
			user_params[:email]
		end
		def password
			user_params[:password]
		end
		def sign?
			if !session[:id].nil?
				head 404
			end
		end
end
