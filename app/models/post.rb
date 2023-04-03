class Post < ApplicationRecord
  belongs_to :user
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true
end
