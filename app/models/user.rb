class User < ActiveRecord::Base
  has_many :statuses
  has_many :albums
  has_many :pictures
  has_many :user_friendships
  has_many :friends, ->{ where(user_friendships: { state: 'accepted' }) }, through: :user_friendships

  has_many :pending_user_friendships, ->{ where(user_friendships: {state: 'pending'}) }, class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  has_many :requested_user_friendships, ->{ where(user_friendships: {state: 'requested'}) }, class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :requested_friends, through: :pending_user_friendships, source: :friend

  has_many :blocked_user_friendships, ->{ where(user_friendships: {state: 'blocked'}) }, class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :blocked_friends, through: :pending_user_friendships, source: :friend

  has_many :accepted_user_friendships, ->{ where(user_friendships: {state: 'accepted'}) }, class_name: 'UserFriendship',
           foreign_key: :user_id

  has_many :accepted_friends, through: :pending_user_friendships, source: :friend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :nick_name, presence: true
  validates :nick_name, uniqueness: true, format: {
                          with:/\A[a-zA-Z\-\_]+\Z/,
                          message: 'Incorrect symbols or letters or whatever.'
                      }

  has_attached_file :avatar,
                    :default_url => '/images/missing.png'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def full_name
    first_name + ' ' + last_name
  end

  def to_param
    nick_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://gravatar.com/avatar/#{hash}"
  end

  def has_blocked?(other)
    blocked_friends.include?(other)
  end
end
