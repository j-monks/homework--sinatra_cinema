require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @name = options["name"]
        @funds = options["funds"].to_i
    end

    # DATABASE METHODS
    def save() # CREATE
        sql = "INSERT INTO customers
        (name, funds)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values)[0]
        @id = customer["id"].to_i
    end

    def self.find(id) # READ
        sql = "SELECT * FROM customers
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values)
        return Customer.new(result[0])
    end

    def self.all() # READ
        sql = "SELECT * FROM customers"
        customers = SqlRunner.run(sql)
        return self.map_items(customers)
    end
    
    def films() # READ
        sql = "SELECT films.* FROM films
        INNER JOIN tickets
        ON films.id = tickets.film_id
        WHERE customer_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        return Film.map_items(result)
    end

    def tickets() # READ
        sql = "SELECT * FROM tickets
        WHERE customer_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        return Ticket.map_items(result)
    end
    
    def ticket_count() # READ
        sql = "SELECT * FROM tickets
        WHERE customer_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        tickets = Ticket.map_items(result)
        return tickets.length
    end

    def update() # UPDATE
        sql = "UPDATE customers SET
        (name, funds)
        =
        ($1, $2)
        WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end

    def delete() # DELETE
        sql = "DELETE FROM customers 
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all() # DELETE
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def self.map_items(data) # HELPER
        return data.map {|customer| Customer.new(customer)}
    end


    # CLASS LOGIC METHODS
    def sufficient_funds?(film)
        if @funds > film.price
            return true
        else
            return false
        end
    end

    def pay_film_price(film)
        @funds -= film.price
    end

end

