class ActivitiesController < ApplicationController
  def index
    # { |f| f.id }
    all_ids = current_user.friends.map(&:id)
    @activities = Activity.where('user_id in (?)', all_ids.push(current_user.id)).order('created_at desc').all
  end
end
