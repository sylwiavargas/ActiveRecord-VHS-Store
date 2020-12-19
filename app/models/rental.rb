class Rental < ActiveRecord::Base
    belongs_to :vhs
    belongs_to :client
end