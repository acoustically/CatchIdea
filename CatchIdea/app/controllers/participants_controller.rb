class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy, :add_opinion, :show_content, :hide_content]
	layout "layouts/idea_contents_layout"
  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
		@idea = @participant.idea
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
      if @participant.update(vote: params[:vote], comment: params[:comment])
        redirect_to({controller: :ideas, action: :show, id: @participant.idea.id})
      else
        head 404
      end
  end
	def add_opinion
		opinion = Content.new
		opinion.opinion = params[:opinion]
		opinion.user_id = session[:id]
		opinion.participant_id = @participant.id
		if (opinion.save)
			redirect_to action: :edit, id: params[:id]
		else
			head 404
		end
	end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def show_content
    @content_id = params[:content_id]
    render layout: false
  end
  def hide_content
    @content_id = params[:content_id]
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:idea_id, :user_id)
    end
end
