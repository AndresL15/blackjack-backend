class Game < ApplicationRecord

    has_many :users

    validates :name, uniqueness: true

    enum state: {jugando: 0, terminado: 1}

end
