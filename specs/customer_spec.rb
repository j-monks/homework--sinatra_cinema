require("minitest/autorun")
require("minitest/reporters")

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../models/customer")
require_relative("../models/film")



class CustomerGuest < MiniTest::Test

    def setup()
        @customer1 = Customer.new({
            "name" => "James",
            "funds" => 30
        })

        @customer2 = Customer.new({
            "name" => "Kayley",
            "funds" => 5
        })

        @film1 = Film.new({
            "title" => "Pulp Fiction",
            "price" => 9
        }) 
    end

    def test_customer_has_name
        assert_equal("James", @customer1.name)
    end

    def test_customer_has_funds
        assert_equal(30, @customer1.funds)
    end

    def test_sufficient_funds__true_if_enough
        assert_equal(true, @customer1.sufficient_funds?(@film1))
    end

    def test_sufficient_funds__false_if_not_enough
        assert_equal(false, @customer2.sufficient_funds?(@film1))
    end

    def test_customer_can_pay_film_price__decreases_money
        @customer1.save()
        @film1.save()
        @customer1.pay_film_price(@film1)
        assert_equal(21, @customer1.funds)
    end

end