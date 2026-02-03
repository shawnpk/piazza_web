module User::Authentication
  extend ActiveSupport::Concern

  included do
    has_secure_password

    has_many :app_sessions

    validates :password, on: [ :create, :password_change ], length: { minimum: 8 }
  end

  class_methods do
    def create_app_session(email:, password:)
      user = User.authenticate_by(email:, password:)
      user.app_sessions.create if user.present?
    end
  end

  def authenticate_app_session(app_session_id, token)
    app_sessions.find(app_session_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
