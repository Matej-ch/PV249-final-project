class ActivitiesController < ApplicationController
  def index

    params[:page] ||= 1
    # { |f| f.id }
    all_ids = current_user.friends.map(&:id)
    @activities = Activity.where('user_id in (?)', all_ids.push(current_user.id)).order('created_at desc').all.paginate(:page => params[:page], :per_page => 20)
  end
end
