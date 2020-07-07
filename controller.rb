require("sinatra")
require("sinatra/contrib/all")

require_relative("models/film")
also_reload("models/*")


get "/films" do
    @all_films = Film.all
    erb(:index)
end

get "/films/:index" do
    @hello = "Hello"
    erb(:details)
end