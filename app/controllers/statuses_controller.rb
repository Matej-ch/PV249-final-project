class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /statuses
  def index
    @statuses = Status.order('updated_at DESC').all
  end

  # GET /statuses/1
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /statuses/1
  def update
    @status = current_user.statuses.find(params[:id])
    if  params[:status] && params[:status].has_key?(:user_id)
      params[:status].delete(:user_id)
    end
    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /statuses/1
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:content, :user_id)
    end
end
