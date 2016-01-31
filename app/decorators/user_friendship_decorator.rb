class UserFriendshipDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def friendship_state
    model.state.titleize
  end

  def sub_message

    case model.state
      when 'pending'
        "Is #{model.friend.first_name} worth it?"
      when 'accepted'
        "You and #{model.friend.full_name} FriendZoned each other"
    end
  end
end
