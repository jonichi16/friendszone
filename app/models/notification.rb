class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true
end
