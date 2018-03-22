class KnowledgeOffersController < ApplicationController
  before_action :set_knowledge_offer, only: [:show, :edit, :update, :destroy, :approve]
  before_action :set_project, only: [:index, :show, :new, :edit, :create, :update, :destroy, :approve]
  before_action :authenticate_user_permission, only: [:edit, :update, :destroy]
  before_action :authenticate_project_owner, only: [:approve]

  # GET /projects/1/knowledge_offers
  # GET /projects/1/knowledge_offers.json
  def index
    @knowledge_offers = KnowledgeOffer.where(project_id: @project.id)
  end

  # GET /projects/1/knowledge_offers/1
  # GET /projects/1/knowledge_offers/1.json
  def show
  end

  # GET /projects/1/knowledge_offers/new
  def new
    @knowledge_offer = KnowledgeOffer.new
  end

  # GET /projects/1/knowledge_offers/1/edit
  def edit
  end

  # POST /projects/1/knowledge_offers
  # POST /projects/1/knowledge_offers.json
  def create
    @knowledge_offer = KnowledgeOffer.new(knowledge_offer_params.merge({
      project_id: @project.id,
      user_id: current_user.id}))

    respond_to do |format|
      if @knowledge_offer.save
        format.html { redirect_to action: 'show', controller: 'knowledge_offers', project_id: @project.id, id: @knowledge_offer.id, notice: 'Knowledge offer was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge_offer }
      else
        format.html { render :new }
        format.json { render json: @knowledge_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1/knowledge_offers/1
  # PATCH/PUT /projects/1/knowledge_offers/1.json
  def update
    respond_to do |format|
      if @knowledge_offer.update(knowledge_offer_params)
        format.html { redirect_to action: 'show', controller: 'knowledge_offers', project_id: @project.id, id: @knowledge_offer.id, notice: 'Knowledge offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge_offer }
      else
        format.html { render :edit }
        format.json { render json: @knowledge_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /projects/1/knowledge_offers/1/approve
  # POST /projects/1/knowledge_offers/1/approve.json
  def approve
    respond_to do |format|
      if @knowledge_offer.update({ approved: true })
        format.html { redirect_to action: 'show', controller: 'knowledge_offers', project_id: @project.id, id: @knowledge_offer.id, notice: 'Knowledge offer was successfully approved.' }
        format.json { render :show, status: :ok, location: @knowledge_offer }
      else
        format.html { render :edit }
        format.json { render json: @knowledge_offer.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /projects/1/knowledge_offers/1
  # DELETE /projects/1/knowledge_offers/1.json
  def destroy
    @knowledge_offer.destroy
    respond_to do |format|
      format.html { redirect_to project_knowledge_offers_url, notice: 'Knowledge offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge_offer
      @knowledge_offer = KnowledgeOffer.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_offer_params
      params.require(:knowledge_offer).permit(:id_str, :description, :callback_url)
    end

    # Authenticate user before allowing modification.
    def authenticate_user_permission
      unless current_user && (current_user.admin || current_user.id == @@knowledge_offer.user.id)
        redirect_to action: 'index', notice: 'Permission denied.'
      end
    end

    # Authenticate user before allowing modification.
    def authenticate_project_owner
      unless current_user && (current_user.admin || current_user.id == @project.user.id)
        redirect_to action: 'show', controller: 'knowledge_offers', project_id: @project.id, id: @knowledge_offer.id, notice: 'Permission denied.'
      end
    end
end
