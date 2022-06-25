class Game < ApplicationRecord

    has_many :blackjacks, dependent: :destroy
    has_many :users, through: :blackjacks

    validates :name, uniqueness: true

end
