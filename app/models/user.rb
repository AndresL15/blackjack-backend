class User < ApplicationRecord

    validates :name, uniqueness: true
    validates :token, uniqueness: true

    before_create :set_token
    
    def set_token
        self.token = SecureRandom.uuid
    end
    
end
