class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :document

  acts_as_votable

  accepts_nested_attributes_for :document
  validates :content, presence: true,
                      length: { minimum: 1 }
  validates :user_id, presence: true

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end



  #ILIKE
  def self.search(search)
    where("content LIKE ?", "%#{search}%")
  end

end
