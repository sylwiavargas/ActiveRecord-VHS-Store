require_relative '../tools/generic_helpers'

class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals

    include GenericHelpers

    #Client.first_rental({name: "bob", home_address: "33 road av"}, "The Color Purple")

    def self.first_rental (client_hash, movie_title)
        new_client = Client.create(client_hash)
        movie = Movie.find_by(title: movie_title)
        vhs_copies = Vhs.where(movie_id: movie.id)
        available_copy = vhs_copies.select {|copy| copy.is_available_to_rent? || !copy.ever_rented? }.first
        Rental.create(vhs_id: available_copy.id , client_id: new_client.id, current: true)
    end

    def num_of_returned_rentals
        Rental.where(client_id: self.id, current: false).count
    end

    def self.most_active
        self.all.each_with_object({}) { |client, hash| hash[client] = client.num_of_returned_rentals }.sort_by(&:last).pop(5)
    end

    # original
    # def favorite_genre
    #     genres_hash = {}
    #     self.rentals.each do |rental| 
    #         rental.vhs.movie.genres.each do |genre|
    #             genres_hash[genre.name].nil? ? genres_hash[genre.name] = 1 : genres_hash[genre.name] += 1 
    #         end
    #     end
    #     genres_hash.max_by(&:last)
    # end

    #refactored above method
    def favorite_genre
        final_hash = self.rentals.each_with_object({}) do |rental, final_hash| 
            temporary_hash = make_hash_by_attribute(rental.vhs.movie.genres, "name")
            final_hash.merge!(temporary_hash) {|key, oldval, newval| newval + oldval}
        end
        final_hash.max_by(&:last)
    end

    def self.non_grata
        self.all.select do |client|
            client.rentals.any? { |rental| rental.returned_late? || rental.past_due? }
        end
    end

    def self.paid_most
        spending_hash = self.all.each_with_object do |client, spending_hash| 
            rented_movies_fees = (client.rentals.count * 5.35).round(2)
            late_movies_fees = (client.late_movies.count * 12.00).round(2)
            total_spent = rented_movies_fees + late_movies_fees
            spending_hash[client] = total_spent
        end
        spending_hash.max_by(&:last)
    end

    def late_movies
        self.rentals.select{|rental| rental.returned_late?}
    end

    def self.total_watch_time
        Rental.all.sum{|rental| rental.vhs.movie.length}
    end

    def return_one(vhs_par)
        rental = Rental.find_by(client_id: self.id, vhs_id: vhs_par.id, current: true)
        rental.update(current: false)
    end

    def active_rentals
        self.rentals.select {|rental| rental.current == true}
    end

    def return_all
        self.active_rentals.map {|rental| rental.update(current: false)}
    end

    def last_return
        self.return_all
        client = Client.find(self.id)
        client.destroy
    end

end