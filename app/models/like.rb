class Like < ApplicationRecord
  after_create :send_like_notification

  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :post_id }

  private

  def send_like_notification
    notifications.create(user_id: post.user_id, sender_id: user_id) unless user == post.user
  end
end
