class ProfilesController < ApplicationController
  def show
    @user = User.find_by_nick_name(params[:id])
    if @user
      @statuses = @user.statuses.all
      render action: :show
    else
      render :file => 'public/404.html', :status => 404, format: [:html]
    end
  end
end
