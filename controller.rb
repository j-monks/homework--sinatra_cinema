require("sinatra")
require("sinatra/contrib/all")

require_relative("models/film")
also_reload("models/*")


get "/films" do
    @all_films = Film.all
    erb(:index)
end

get "/films/:index" do
    @all_films = Film.all.map { |film| film }
    @index = params[:index].to_i - 1
    erb(:details)
end