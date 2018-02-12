class KnowledgeOffersController < ApplicationController
  before_action :set_knowledge_offer, only: [:show, :edit, :update, :destroy]

  # GET /knowledge_offers
  # GET /knowledge_offers.json
  def index
    @knowledge_offers = KnowledgeOffer.all
  end

  # GET /knowledge_offers/1
  # GET /knowledge_offers/1.json
  def show
  end

  # GET /knowledge_offers/new
  def new
    @knowledge_offer = KnowledgeOffer.new
  end

  # GET /knowledge_offers/1/edit
  def edit
  end

  # POST /knowledge_offers
  # POST /knowledge_offers.json
  def create
    @knowledge_offer = KnowledgeOffer.new(knowledge_offer_params)

    respond_to do |format|
      if @knowledge_offer.save
        format.html { redirect_to @knowledge_offer, notice: 'Knowledge offer was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge_offer }
      else
        format.html { render :new }
        format.json { render json: @knowledge_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knowledge_offers/1
  # PATCH/PUT /knowledge_offers/1.json
  def update
    respond_to do |format|
      if @knowledge_offer.update(knowledge_offer_params)
        format.html { redirect_to @knowledge_offer, notice: 'Knowledge offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge_offer }
      else
        format.html { render :edit }
        format.json { render json: @knowledge_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledge_offers/1
  # DELETE /knowledge_offers/1.json
  def destroy
    @knowledge_offer.destroy
    respond_to do |format|
      format.html { redirect_to knowledge_offers_url, notice: 'Knowledge offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge_offer
      @knowledge_offer = KnowledgeOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_offer_params
      params.require(:knowledge_offer).permit(:id_str, :description, :callback_url, :approved, :project_id, :user_id)
    end
end
