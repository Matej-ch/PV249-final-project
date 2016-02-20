require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)
  should have_many(:pending_user_friendships)
  should have_many(:pending_friends)
  should have_many(:requested_user_friendships)
  should have_many(:requested_friends)
  should have_many(:blocked_user_friendships)
  should have_many(:blocked_friends)
  should have_many(:activities)
  should have_many(:conversations)

  test ' user should enter a first name' do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test ' user should enter a last name' do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test ' user should enter a nick name' do
    user = User.new
    assert !user.save
    assert !user.errors[:nick_name].empty?
  end

  test ' user should have a unique nick name' do
    user = User.new
    user.nick_name = users(:vlado).nick_name

    assert !user.save
    assert !user.errors[:nick_name].empty?
  end

  test ' user should have a nick name without spaces' do
    user = User.new(first_name: 'Vlado', last_name: 'Traveler', email: 'vlado@gmail.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.nick_name = 'My Profile With Spaces'

    assert !user.save
    assert !user.errors[:nick_name].empty?
    assert user.errors[:nick_name].include?('Incorrect symbols or letters or whatever.')
  end

  test 'user can have a correctly formatted nick name' do
    user = User.new(first_name: 'Test', last_name: 'TestLast', email: 'vlado@test.com')
    user.password = user.password_confirmation = 'asdfasdf'

    user.nick_name = 'test'
    assert user.valid?
  end

  test 'that no error is raised when trying to access a friend list' do
    assert_nothing_raised do
      users(:vlado).friends
    end
  end

  test 'that creating friendships on a user works' do
    users(:vlado).pending_friends << users(:mato)
    users(:vlado).pending_friends.reload
    assert users(:vlado).pending_friends.include?(users(:mato))
  end

  test 'that calling to_param on a user returns the nick_name' do
    assert_equal 'vladotraveler', users(:vlado).to_param
  end

  context '#has_blocked?' do
    should 'return true if a user has blocked another user' do
      assert users(:vlado).has_blocked?(users(:blocked_friend))
    end

    should 'return false if a user has not blocked another user' do
      assert !users(:vlado).has_blocked?(users(:tomas))
    end
  end

  context '#create_activity' do
    should 'increas the Activity count' do
      assert_difference 'Activity.count' do
        users(:vlado).create_activity(statuses(:one), 'created')
      end
    end

    should 'set the targetable instance to the item passed in' do
      activity = users(:vlado).create_activity(statuses(:one), 'created')
      assert_equal statuses(:one), activity.targetable
    end

    should 'increase the Activity count with an album' do
      assert_difference 'Activity.count' do
        users(:vlado).create_activity(albums(:vacation), 'created')
      end
    end

    should 'set the targetable instance to the item passed in with an album' do
      activity = users(:vlado).create_activity(albums(:vacation), 'created')
      assert_equal albums(:vacation), activity.targetable
    end
  end
end
