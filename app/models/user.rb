class User < ApplicationRecord

    validates :name, uniqueness: true
    validates :token, uniqueness: true

    before_create :set_token
    
    def set_token
        self.token = SecureRandom.uuid
    end

    #before_validation(on: :create) do
    #    self.cards = ""
    #end 
    
end
