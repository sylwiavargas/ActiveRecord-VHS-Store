require_relative '../tools/generic_helpers'

class MovieGenre < ActiveRecord::Base
    belongs_to :genre
    belongs_to :movie
end