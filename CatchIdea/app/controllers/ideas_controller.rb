class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
	layout "layouts/main_layout"
	@@add_count = 0
	@@remove_count = 0
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = User.find_by(id: session[:id]).ideas
		render layout: "/layouts/friend_layout"
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
		@idea.user_id = session[:id]

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	def add_participant
		@@add_count += 1
		@participant_num = @@add_count
		@index = params[:index]
		@participant = Friend.find_by(id: params[:participant])
		render layout: false
	end
	def add_participant_from_email
		@@add_count += 1
		@participant_num = @@add_count
		@participant = User.find_by(email: params[:email])
		render layout: false
	end
	def remove_participant
		@@remove_count += 1
		@stand_by_num = @@remove_count
		@index = params[:index]
		@participant = Friend.find_by(id: params[:participant])
		render layout: false
	end
	def remove_participant_from_email
		@stand_by_num = @@remove_count + User.find_by(id: session[:id]).friends.length
		@index = params[:index]
		render layout: false
	end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:user_id, :name)
    end
end
