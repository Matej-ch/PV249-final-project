class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /statuses
  def index
    # @statuses = Status.order('updated_at DESC').all
    if params[:search]
      @statuses = Status.search(params[:search]).order('updated_at DESC')
    else
      @statuses = Status.all.order('updated_at DESC')
    end
  end

  # GET /statuses/1
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
    @status.build_document
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        current_user.create_activity(@status,'created')
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /statuses/1
  def update
    @status = current_user.statuses.find(params[:id])
    @document = @status.document

    @status.transaction do
      @status.update_attributes(params[:status])
      @document.update_attributes(params[:status][:document]) if @document
      current_user.create_activity(@status,'updated')
      unless @status.valid? || (@status.valid? && @document && !document.valid?)
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      format.html { redirect_to @status, notice: 'Status was successfully updated.' }
    end

  rescue ActiveRecord::Rollback
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Update failed'
          render :edit
        end
        format.html { render :edit }
    end
  end

  # DELETE /statuses/1
  def destroy
    @status.destroy
    current_user.create_activity(@status,'deleted')
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
    end
  end

  def upvote
    @status = Status.find(params[:id])
    @status.upvote_by current_user
    redirect_to root_path
  end

  def downvote
    @status = Status.find(params[:id])
    @status.downvote_by current_user
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:content, :user_id, :document_attributes => [:attachment])
    end
end
