class Friend < ApplicationRecord
  after_create :request_friend, :send_friend_request_notification
  after_update :send_accepted_request_notification

  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :notifications, as: :notifiable, dependent: :destroy

  enum :status, { pending: 0, accepted: 1 }

  validates :user_id, uniqueness: { scope: :friend_id }

  scope :followed_by, ->(user) { where("friend_id = ? AND status = ?", user.id, 1) }
  scope :friends, ->(user) { where("user_id = ? AND status = ?", user, 1) }

  private

  def request_friend
    Friend.create(user_id: friend_id, friend_id: user_id, status: 0)
  end

  def send_friend_request_notification
    notifications.create!(user_id:, sender_id: friend_id) if pending?
  end

  def send_accepted_request_notification
    notifications.create!(user_id: friend_id, sender_id: user_id) if accepted?
  end
end
