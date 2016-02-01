class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def index
    @user_friendships = UserFriendshipDecorator.decorate_collection(friendship_assoc.all)
    respond_with @user_friendships
  end

  def accept
    @user_friendships = current_user.user_friendships.find(params[:id])
    if @user_friendships.accept!
      current_user.create_activity(@user_friendships,'accepted')
      flash[:success] = "You are now FriendZoned by #{@user_friendships.friend.first_name}"
    else
      flash[:error] = 'That friendship would not work anyway'
    end
    redirect_to user_friendships_path
  end

  def edit
    @friend = User.where(nick_name: params[:id]).first
    @user_friendship = current_user.user_friendships.where(friend_id: @friend.id).first.decorate
  end

  def new
    if params[:friend_id]
      @friend = User.where(nick_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "You need friends"
    end

    rescue ActiveRecord::RecordNotFound
      render :file => 'public/404.html', :status => 404, format: [:html]
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.where(nick_name: params[:user_friendship][:friend_id]).first
      @user_friendship = UserFriendship.request(current_user, @friend)
      respond_to do |format|
        if @user_friendship.new_record?
          format.html { redirect_to profile_path(@friend), error: 'There was a problem' }
        else
          format.html { redirect_to profile_path(@friend), notice: "You just Friendzoned #{ @friend.full_name }" }
        end
      end
    else
      flash[:error] = "You need friends"
      redirect_to root_path
    end
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.destroy
      flash[:success] = 'It\'s all over now. Nothing matters anymore'
    end
    redirect_to user_friendships_path
  end

  def block
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.block!
      flash[:success] = "You have successfully blocked #{@user_friendship.friend.first_name} from your life"
    else
      flash[:error] = "We are truly sorry, we couldn't block #{@user_friendship.friend.first_name} from your life :("
    end
    redirect_to user_friendships_path
  end

  private
  def user_friendship_params
    params.require(:user_friendship).permit(:friend, :user,:friend_id , :user_id, :state)
  end

  def friendship_assoc
    case params[:list]
      when nil
        current_user.user_friendships
      when 'blocked'
        current_user.blocked_user_friendships
      when 'pending'
       current_user.pending_user_friendships
      when 'accepted'
        current_user.accepted_user_friendships
      when 'requested'
        current_user.requested_user_friendships
    end
  end
end
