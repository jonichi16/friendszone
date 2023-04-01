class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, { pending: 0, accepted: 1 }

  after_create :request_friend
  after_destroy :delete_friend

  validates :user_id, uniqueness: { scope: :friend_id }

  scope :followed_by, ->(user) { where("friend_id = ? AND status = ?", user.id, 1) }
  scope :friends, ->(user) { where("user_id = ? AND status = ?", user, 1) }

  private

  def request_friend
    Friend.create(user_id: friend_id, friend_id: user_id, status: 0)
  end

  def delete_friend
    @friend = Friend.where("user_id = ? AND friend_id = ?", friend_id, user_id)
    friend.friends.destroy(@friend)
  end
end
