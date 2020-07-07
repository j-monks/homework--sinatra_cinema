require("pry-byebug")
require_relative("models/ticket")
require_relative("models/customer.rb")
require_relative("models/film")
require_relative("models/screening")

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()

# CUSTOMERS
customer1 = Customer.new({
    "name" => "James",
    "funds" => 30
})
customer1.save()

customer2 = Customer.new({
    "name" => "Kayley",
    "funds" => 60
})
customer2.save()

# FILMS
film1 = Film.new({
    "title" => "Pulp Fiction",
    "price" => 9
})
film1.save()

film2 = Film.new({
    "title" => "Fight Club",
    "price" => 5
})
film2.save()

# TICKET
ticket = Ticket.new({})

# SCREENINGS
screening1 = Screening.new({
    "show_time" => "20:00",
    "film_title" => film2.title
})
screening1.save()

screening2 = Screening.new({
    "show_time" => "16:00",
    "film_title" => film1.title
})
screening2.save()

screening3 = Screening.new({
    "show_time" => "18:00",
    "film_title" => film2.title
})
screening3.save()

# BOUGHT TICKETS
ticket1 = ticket.sell_ticket_to_customer(customer1, film2, screening1)
ticket2 = ticket.sell_ticket_to_customer(customer2, film2, screening1)
ticket3 = ticket.sell_ticket_to_customer(customer1, film2, screening3)

# VARIABLES
all_tickets = Ticket.all()
all_customers = Customer.all()
all_films = Film.all()

# CHECK HOW MANY TICKETS WERE BOUGHT BY A CUSTOMER
customer1_ticket_count = customer1.ticket_count()

# CHECK HOW MANY CUSTOMERS ARE GOING TO WATCH A CERTAIN FILM
film2_customer_count = film2.customer_count()

# CREATE A SCREENINGS TABLE THAT LETS US KNOW WHAT TIME FILMS ARE SHOWING
film1_showtimes = Screening.show_times(film1.title)
film2_showtimes = Screening.show_times(film2.title)

# WRITE A METHOD THAT FINDS OUT WHAT IS THE MOST POPULAR TIME ( MOST TICKETS SOLD ) FOR A GIVEN FILM
film2_most_popular_showtime = Screening.most_popular_showtime_by_film(film2.id)

 binding.pry
 nil

