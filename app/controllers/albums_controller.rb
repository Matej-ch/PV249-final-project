class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :new, :update, :edit, :destroy]
  before_filter :find_user
  before_filter :find_album, only: [:edit, :update, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs
  # GET /albums
  # GET /albums.json
  def index
    @albums = @user.albums.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    redirect_to album_pictures_path(params[:id])
  end

  # GET /albums/new
  def new
     @album = current_user.albums.new
     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @album }
     end
  end

  # GET /albums/1/edit
  def edit
    add_breadcrumb 'Editing Gallery'
  end

  # POST /albums
  # POST /albums.json
  def create
    @album =  current_user.albums.new(album_params)

    respond_to do |format|
      if @album.save
        current_user.create_activity(@album,'created')
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        #format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        #format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        current_user.create_activity(@album,'updated')
        format.html { redirect_to album_pictures_path, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    current_user.create_activity(@album,'deleted')
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def url_options
    { nick_name: params[:nick_name]}.merge(super)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:user_id, :title, :album_id)
    end

    def find_user
      @user = User.find_by_nick_name(params[:nick_name])
    end

    def find_album
      @album = current_user.albums.find(params[:id])
    end

  def ensure_proper_user
    if current_user != @user
      flash[:error] = 'You dont dave permissions'
      redirect_to album_path
    end
  end

  def add_breadcrumbs
    add_breadcrumb @user, profile_path(@user)
    add_breadcrumb 'Galleries', albums_path
  end
end
