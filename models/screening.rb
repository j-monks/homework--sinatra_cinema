require_relative("../db/sql_runner")

class Screening

    attr_reader :id
    attr_accessor :show_time, :film_title

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @show_time = options["show_time"] 
        @film_title = options["film_title"]
    end

    def save() # CREATE
        sql = "INSERT INTO screenings
        (show_time, film_title)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@show_time, @film_title]
        screening = SqlRunner.run(sql, values)[0]
        @id = screening["id"].to_i
    end

    def self.show_times(film_title) # READ
        sql = "SELECT * FROM screenings
        WHERE film_title = $1"
        values = [film_title]
        screenings = SqlRunner.run(sql, values)
        return self.map_items(screenings)
    end

    def self.most_popular_showtime_by_film(film_id) # READ
        # TAKES THE FILM ID AND RETRIEVES ALL SCREENING ID'S FOR THAT FILM
        sql = "SELECT tickets.screening_id FROM tickets 
        WHERE film_id = $1"
        values = [film_id]
        screening_ids = SqlRunner.run(sql, values)
        # TAKES ALL THE SCREENINGS AND FOR EVERY MATCHING SCREENING ID ADDS 1 AS A VALUE TO A INDIVIDUAL SCREENING
        screenings = Hash.new(0)
        screening_ids.each { |screening| screenings[screening] += 1 }
        # SORTS ALL THE SCREENINGS STARTING WITH THE MOST POPULAR TO THE LEAST POPULAR
        sorted_screenings = screenings.sort_by {|_key, value| -value}.to_h
        most_popular_key = sorted_screenings.keys[0]
        # PULLS OUT THE MOST POPULAR SCREENING TIME (ID) & MATCHES IT IN THE DATABASE AND RETRIEVES THE SPECIFIC SHOW TIME
        screening_id = most_popular_key.values
        sql2 = "SELECT screenings.show_time FROM screenings 
        WHERE id = $1"
        values2 = [screening_id[0].to_i]
        show_time = SqlRunner.run(sql2, values2)
        return show_time[0].values
    end

    def self.delete_all() # DELETE
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end

    def self.map_items(data) # HELPER
        return data.map {|screening| Screening.new(screening)}
    end

end