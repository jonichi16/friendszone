class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: true

  def self.posts(user)
    posts_user = user.friends.pluck(:friend_id) << user.id
    where(user_id: posts_user).includes(:user, :likes).order(created_at: :desc).limit(20)
  end
end
