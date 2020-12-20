class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals

    def past_rentals
        self.rentals.select{|rental| !rental.current}
    end

    def self.most_active
        # 1. get the number of past rentals
        # 3. iterate over that array to get the five most active ones
        self.all.sort_by{|client| client.past_rentals.count}.reverse[0..4]
    end

    def movies
        self.vhs.map(&:movie)
    end

    def genres
        genres = movies.map(&:genres).flatten
    end

    def favorite_genre_hash
        genre_hash = {}
        genres.each do |genre|
            key = genre.name
            if genre_hash[key]
                genre_hash[key]["count"] += 1 
            else 
                genre_hash[key] = {}
                genre_hash[key]["genre"] = genre
                genre_hash[key]["count"] = 1
            end
        end
        genre_hash
    end

    def favorite_genre        
        favorite_genre_hash.max_by(&:count)[1]
    end

    def self.non_grata
        # returns a list of all the clients who have a vhs past the due date
        Rental.currently_past_due_date.map(&:client).uniq
        # or: who ever missed the return date
        # Rental.past_due_date.map(&:client).uniq
    end

    def return_one(vhs)
        rental = self.rentals.find{|r| r.vhs == vhs}
        rental.update(current: false)
    end

    def return_all
        self.rentals.update_all(current: false)
    end

    def spent_money
        rentals_number = self.rentals.count
        (rentals_number * 5.35).round(2)
    end

    def late_fees
        self.rentals.count{|r| !r.current && r.past_due_date?} * 12
    end

    def total_paid
        self.spent_money + self.late_fees
    end

    def self.paid_most
        # returns an instance who has spent most money at the store
        self.all.max_by(&:spent_money)
        # bonus: additional $12 charge for every late return — do not count those that have not yet been returned
        # self.all.max_by(&:total_paid)
    end

    def total_watch_time
        self.vhs.sum{|vhs| vhs.movie.length}
    end

    def self.total_watch_time
        self.all.sum{|client| client.total_watch_time}
    end
end