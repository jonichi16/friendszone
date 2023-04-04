class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  enum :status, { unseen: 0, seen: 1, reviewed: 2 }

  def self.get_notifications(user)
    includes(:sender, :notifiable).where(user_id: user).reverse_order.limit(20)
  end
end
