class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  attr_writer :login

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /^[a-zA-Z0-9_.]*$/, multiline: true }
  validates :name, presence: true

  has_many :friends, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

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

  def self.people(current_user)
    @friends = current_user.friends.pluck(:friend_id)
    @excluded = @friends << current_user.id
    @people = User.where.not(id: @excluded).limit(20)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.username = username_generator(auth.info.name)
      user.name = auth.info.name
    end
  end

  def self.username_generator(first_name)
    uniqname = first_name.downcase.downcase.tr(" ", "_")
    num = 1
    until User.find_by(username: uniqname).nil?
      uniqname << "-#{num}"
      num += 1
    end
    uniqname
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update(params, *options)
    else
      super
    end
  end
end
