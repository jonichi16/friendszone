class Comment < ApplicationRecord
  after_create :send_comment_notification

  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  private

  def send_comment_notification
    notifications.create(user_id: post.user_id, sender_id: user_id) unless user == post.user
  end
end
