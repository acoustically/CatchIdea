class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]
	layout "layouts/main_layout"
  # GET /friends
  # GET /friends.json
  def index
    @friends = User.find_by(id: session[:id]).friends
		render layout: "layouts/friend_layout"
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new
		@friend.user_id = session[:id]
		user = find_user(get_email)
		if !user.nil?
			@friend.current_id = user.id
			@friend.name = user.name
			if !(user.email == session[:email]) && @friend.save
       	redirect_to action: :index
			else
				redirect_to action: :new
			end
    else
      redirect_to action: :new
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to action: :index }
        format.json { render :show, status: :ok, location: @friend }
			else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:user_id, :name)
    end
		def get_email
			params[:email]
		end
		def find_user email
			User.all.find_by(email: email)
		end
end
