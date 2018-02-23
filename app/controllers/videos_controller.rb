class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_project_owner, only: [:edit, :update, :destroy]

  # GET /projects/1/videos
  # GET /projects/1/videos.json
  def index
    @videos = Video.all
  end

  # GET /projects/1/videos/1
  # GET /projects/1/videos/1.json
  def show
  end

  # GET /projects/1/videos/new
  def new
    @video = Video.new
  end

  # GET /projects/1/videos/1/edit
  def edit
  end

  # POST /projects/1/videos
  # POST /projects/1/videos.json
  def create
    @video = Video.new(video_params.merge({ project_id: @project.id }))

    respond_to do |format|
      if @video.save
        format.html { redirect_to action: 'show', controller: 'videos', project_id: @project.id, id: @video.id, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1/videos/1
  # PATCH/PUT /projects/1/videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params.merge({ project_id: @project.id }))
        format.html { redirect_to action: 'show', controller: 'videos', project_id: @project.id, id: @video.id, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/videos/1
  # DELETE /projects/1/videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :path)
    end

    # Authenticate user before allowing modification.
    def authenticate_project_owner
      unless current_user && (current_user.admin || current_user.id == @project.user.id)
        redirect_to action: 'show', controller: 'videos', project_id: @project.id, id: @video.id, notice: 'Permission denied.'
      end
    end
end
