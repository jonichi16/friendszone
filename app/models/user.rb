class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /^[a-zA-Z0-9_.]*$/, multiline: true }
  validates :name, presence: true

  has_many :friends, dependent: :destroy

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(
        ["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]
      ).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.exists?(email: username)
      errors.add(:username, :invalid)
    end
  end
end
