class Vhs < ActiveRecord::Base
    belongs_to :movie
    has_many :rentals
    has_many :clients, through: :rentals
    after_initialize :add_serial_number

    def add_serial_number
        serial_number = serial_number_stub
        alphanumerics = (0...36).map{ |i| i.to_s 36 }
        13.times{|t| serial_number << alphanumerics.sample}
        self.update(serial_number: serial_number)
    end

    private

    # these methods generate a serial number

    def long_title?
        !self.movie.title.nil? && self.movie.title.length > 2
    end

    def two_part_title?
        !self.movie.title.split(" ")[1].nil? && self.movie.title.split(" ")[1].length > 2
    end

    def serial_number_stub
        return "X" if self.movie.title.nil?
        return self.movie.title.split(" ")[1][0..3].gsub(/s/, "").upcase + "-" if two_part_title?
        return self.movie.title.gsub(/s/, "").upcase + "-" unless long_title?
        self.movie.title[0..3].gsub(/s/, "").upcase + "-"
    end
end