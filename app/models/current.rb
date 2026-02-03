class Current < ActiveSupport::CurrentAttributes
  attribute :app_session, :organization, :user
end
