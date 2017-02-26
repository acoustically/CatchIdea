class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :update_discription, :add_participant_in_edit, :remove_participant_in_edit]  
  before_action :reset_participants, except: [:new_next, :add_participant, :add_participant_from_email, :remove_participant, :remove_participant_from_email, :create, :add_participant_in_edit, :remove_participant_in_edit]
  layout "layouts/main_layout"
  @@participant_div_count = 0
  @@awaiter_div_count = 0
  @@participants = Array.new
  @@participants_count = 0
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = User.find_by(id: session[:id]).ideas
    render layout: "/layouts/friend_layout"
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @user = Participant.find_by(user_id: session[:id], idea_id: @idea.id)
    render layout: "layouts/idea_contents_layout"
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end
  def new_next
    @idea = Idea.new
    @name = idea_params[:name]
  end

  # GET /ideas/1/edit
  def edit
    @user = Participant.find_by(user_id: session[:id], idea_id: @idea.id)
    if (@user.permission != 2)
      head 404
    end
    render layout: "layouts/idea_layout"
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.name = params[:name]
    @idea.user_id = session[:id]
    @@participants = @@participants.uniq
    @@participants.each do |p|
     	@idea.users << p
    end
    @idea.users << User.find_by(id: session[:id])
    respond_to do |format|
      if @idea.save
        @@participants.each do |p|
          make_participant(@idea.id, p.id, 0)
        end
        make_participant(@idea.id, session[:id], 2)
        format.html { redirect_to controller: :ideas, action: :index, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        reset_participant
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    @idea.update(idea_params)
    redirect_to action: :show, id: params[:id]
  end
  def update_discription
    @idea.update(discription: params[:discription])
    redirect_to action: :show, id: @idea.id
	end
  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.users.delete(User.find_by(id: session[:id]))
    if (Participant.find_by(idea_id: @idea.id).nil?)
      Participant.destroy_all(idea_id: @idea.id)
      Content.destroy_all(idea_id: @idea.id)
      @idea.destroy
    end
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def add_participant
    @@participant_div_count += 1
    @participant_div_index = @@participant_div_count
    @awaiter_div_index = params[:awaiter_div_index]
    @participant = Friend.find_by(id: params[:awaiter_id])

    @@participants << User.find_by(id: @participant.current_id)
    @@participants_count += 1
    @participants_index = @@participants_count
    render layout: false
  end
  def add_participant_from_email
    @@participant_div_count += 1
    @participant_div_index = @@participant_div_count
    @participant = User.find_by(email: params[:participant_email])

    @@participants << @participant
    @@participants_count += 1
    @participants_index = @@participants_count
    render layout: false
  end
  def remove_participant
    @@awaiter_div_count += 1
    @awaiter_div_index = @@awaiter_div_count
    @participant_div_index = params[:participant_div_index]
    @participant = Friend.find_by(id: params[:participant_id])

    @@participants.delete_at(Integer(params[:participants_index]))
    @@participants_count -= 1
    render layout: false
  end
  def remove_participant_from_email
    @participant_div_index = params[:participant_div_index]
    @@participants.delete_at(Integer(params[:participants_index]))
    @@participants_count -= 1
    render layout: false
  end
  def add_participant_in_edit
    @@participant_div_count += 1
    @participant_div_index = @@participant_div_count
    @participant = User.find_by(email: params[:participant_email])
    if @participant.nil? || !Participant.find_by(idea_id: @idea.id, user_id: @participant.id).nil?
      return
    else
      make_participant(@idea.id, User.find_by(email: params[:participant_email]).id, 0)
      @idea.users << @participant
    end
    render layout: false
  end
  def remove_participant_in_edit
    @@participant_div_count -= 1
    @participant_div_index = params[:participant_div_index]
    Participant.find_by(user_id: params[:participant_id], idea_id: @idea.id).destroy
    @idea.users.delete(User.find_by(id: params[:participant_id]))
    render layout: false
  end
  private
    def make_participant(idea_id, user_id, permission)
      participant = Participant.new
      participant.idea_id = idea_id
      participant.user_id = user_id
      participant.permission = permission
      participant.save
    end
    def reset_participants
      @@participants = Array.new
      @@participant_div_count = 0
      @@participants_count = 0
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:user_id, :name, :deadline, :discription, :subtitle, :deadline_time)
    end
end
