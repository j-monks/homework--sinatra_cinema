require("minitest/autorun")
require("minitest/reporters")

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../models/ticket")
require_relative("../models/customer")
require_relative("../models/film")



class TicketGuest < MiniTest::Test
    
    def setup()
        @customer1 = Customer.new({
            "name" => "James",
            "funds" => 30
        })

        @customer2 = Customer.new({
            "name" => "Kayley",
            "funds" => 15
        })

        @film1 = Film.new({
            "title" => "Pulp Fiction",
            "price" => 9
        }) 

        @ticket = Ticket.new({})
    end


    def test_can_create_ticket()
        Ticket.delete_all()
        Customer.delete_all()
        Film.delete_all()

        assert_equal(0, Ticket.all().length())

        @customer1.save()
        @film1.save()
        @ticket.create_ticket(@customer1, @film1)
        
        assert_equal(1, Ticket.all().length())
    end

    def test_sell_ticket_to_customer()
        Ticket.delete_all()
        Customer.delete_all()
        Film.delete_all()

        @customer1.save()
        @film1.save()
        @ticket.sell_ticket_to_customer(@customer1, @film1)

        assert_equal(1, Ticket.all().length())
    end
    
end
