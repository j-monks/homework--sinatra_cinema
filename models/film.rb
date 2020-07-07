require_relative("../db/sql_runner")

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @title = options["title"] 
        @price = options["price"].to_i  
    end

    def save() # CREATE
        sql = "INSERT INTO films
        (title, price)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@title, @price]
        film = SqlRunner.run(sql, values)[0]
        @id = film["id"].to_i
    end

    def self.all() # READ
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        return self.map_items(films)
    end

    def self.find(id) # READ
        sql = "SELECT * FROM films
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values)
        return Film.new(result[0])
    end

    def customers() # READ
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets
        ON customers.id = tickets.customer_id
        WHERE film_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        return Customer.map_items(result)
    end

    def customer_count() # READ
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets
        ON customers.id = tickets.customer_id
        WHERE film_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        customers = Customer.map_items(result)
        return customers.length
    end
    
    def update() # UPDATE
        sql = "UPDATE films SET
        (title, price)
        =
        ($1, $2)
        WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    def delete() # DELETE
        sql = "DELETE FROM films 
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all() # DELETE
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

    def self.map_items(data) # HELPER
        return data.map {|film| Film.new(film)}
    end

end