class Credential < ApplicationRecord
    belongs_to :user, :foreign_key => 'user_id'
    def as_json
        {
            access_token: access_token,
            refresh_token: refresh_token
        }
    end
end
