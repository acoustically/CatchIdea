class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
	skip_before_action :sign_in?, only: [:sign_in, :new, :sign_in_end]
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
		if !User.find_by(email: email).nil?
			redirect_to url_for({controller: :users, action: :new}), notice: 'Emaiil is invalid or already taken'
			return
		end
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	def sign_in
		@user = User.new
		render layout: "layouts/sign_layout"
	end
	def sign_in_end
		@users = User.all
		if !@users.find_by(email: email, password: password).nil?
			reset_session
			session[:email] = email
			session[:password] = password
			redirect_to url_for(controller: :layout_test, action: :test_page, id: 1)
		else 
			redirect_to url_for(action: :sign_in, id: 0)
		end
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
end
