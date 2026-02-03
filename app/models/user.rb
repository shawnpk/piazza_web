class User < ApplicationRecord
  include Authentication

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  normalizes :name, with: ->(name) { name.strip }
  normalizes :email, with: ->(email) { email.strip.downcase }
end
