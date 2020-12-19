class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals

end