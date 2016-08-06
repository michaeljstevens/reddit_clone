class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :subs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :subscription_links,
    foreign_key: :user_id,
    class_name: :Subscription

  has_many :subscriptions,
    through: :subscription_links,
    source: :sub

  has_many :subbed_posts,
    through: :subscriptions,
    source: :posts

  attr_reader :password

  def self.find_by_credentials(username, pass)
    user = User.find_by(username: username)
    return nil unless user && user.is_password?(pass)
    user
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end
end
