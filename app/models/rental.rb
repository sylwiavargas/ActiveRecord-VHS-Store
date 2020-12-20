class Rental < ActiveRecord::Base
    belongs_to :vhs
    belongs_to :client

    def due_date
        self.created_at + 7.days
    end

    def self.past_rentals_currently_available_movies
        self.all.select{|rental| !rental.current}.map(&:vhs).map(&:movie).to_set
    end

    def past_due_date?
        self.due_date < self.updated_at
    end

    def self.past_due_date
        self.all.select{|rental| rental.past_due_date?}
    end

    def self.currently_past_due_date
        self.all.select{|rental| rental.current && rental.due_date < rental.updated_at}
    end

end