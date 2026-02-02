class User < ApplicationRecord
  has_secure_password

  has_many :app_sessions
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }

  normalizes :name, with: ->(name) { name.strip }
  normalizes :email, with: ->(email) { email.strip.downcase }

  def self.create_app_session(email:, password:)
    user = User.authenticate_by(email:, password:)
    user.app_sessions.create if user.present?
  end

  def authenticate_app_session(app_session_id, token)
    app_sessions.find(app_session_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
