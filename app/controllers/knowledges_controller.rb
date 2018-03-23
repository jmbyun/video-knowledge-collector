class KnowledgesController < ApplicationController
  before_action :set_knowledge, only: [:show, :edit, :update, :destroy]
  before_action :set_video, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_project, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_knowledge_offer, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user_permission, only: [:new, :create, :edit, :update, :destroy]
  before_action :validate_knowledge_offer_approval, only: [:new, :create, :edit, :update, :destroy]

  # GET /projects/1/videos/1/knowledges
  # GET /projects/1/videos/1/knowledges.json
  def index
    @knowledges = Knowledge.all
  end

  # GET /projects/1/videos/1/knowledges/1
  # GET /projects/1/videos/1/knowledges/1.json
  def show
  end

  # GET /projects/1/videos/1/knowledges/new
  def new
    @knowledge = Knowledge.new
  end

  # GET /projects/1/videos/1/knowledges/1/edit
  def edit
  end

  # POST /projects/1/videos/1/knowledges
  # POST /projects/1/videos/1/knowledges.json
  def create
    @knowledge = Knowledge.new(knowledge_params.merge({
      video_id: @video.id,
      knowledge_offer_id: @knowledge_offer.id,
      user_id: current_user.id }))

    respond_to do |format|
      if @knowledge.save
        format.html { redirect_to action: 'show', controller: 'knowledges', project_id: @project.id, video_id: @video.id, id: @knowledge.id, notice: 'Knowledge was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge }
      else
        format.html { render :new }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1/videos/1/knowledges/1
  # PATCH/PUT /projects/1/videos/1/knowledges/1.json
  def update
    respond_to do |format|
      if @knowledge.update(knowledge_params.merge({
        video_id: @video.id,
        knowledge_offer_id: @knowledge_offer.id,
        user_id: current_user.id }))

        format.html { redirect_to action: 'show', controller: 'knowledges', project_id: @project.id, video_id: @video.id, id: @knowledge.id, notice: 'Knowledge was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge }
      else
        format.html { render :edit }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/videos/1/knowledges/1
  # DELETE /projects/1/videos/1/knowledges/1.json
  def destroy
    @knowledge.destroy
    respond_to do |format|
      format.html { redirect_to project_video_knowledges_url, notice: 'Knowledge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge
      @knowledge = Knowledge.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:video_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge_offer
      if params[:knowledge_offer_id]
        @knowledge_offer = KnowledgeOffer.find(params[:knowledge_offer_id])
      else
        knowledge_offers = KnowledgeOffer.where(user_id: current_user.id, project_id: params[:project_id])
        if knowledge_offers.empty?
          @knowledge_offer = nil
        else
          @knowledge_offer = knowledge_offers.first
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_params
      params.require(:knowledge).permit(:body)
    end

    # Authenticate user before allowing modification.
    def authenticate_user_permission
      unless current_user && @knowledge_offer && (current_user.admin || (@current_user.id == @knowledge_offer.user.id))
        redirect_to action: 'index', notice: 'Permission denied.'
      end
    end

    # Authenticate knowledge offer's
    def validate_knowledge_offer_approval
      unless @knowledge_offer && @knowledge_offer.approved
        redirect_to action: 'index', notice: 'Approved knowledge offer required.'
      end
    end
end
