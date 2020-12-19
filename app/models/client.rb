class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhss, through: :rentals

end