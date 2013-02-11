require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'httparty'
require 'json'
require 'pg'

get '/' do
  erb :home
end

get '/info' do
  erb :info
end

get '/poster' do

  erb :poster
end

get '/movies' do
  sql = 'SELECT poster FROM movies;'

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close

  erb :movies
end

post '/movie' do
  if params[:movie]
    results = params[:movie].downcase.gsub(' ', '+')
    url = "http://www.omdbapi.com/?t=#{results}"
    html = HTTParty.get(url).gsub("'", "")
    @hash = JSON(html)

    sql = "INSERT INTO movies (title, year, rated, released, runtime, genre, director, writers, actors, plot, poster) VALUES ('#{@hash['Title']}', '#{@hash['Year']}', '#{@hash['Rated']}', '#{@hash['Released']}', '#{@hash['Runtime']}', '#{@hash['Genre']}', '#{@hash['Director']}', '#{@hash['Writers']}', '#{@hash['Actors']}', '#{@hash['Plot']}', '#{@hash['Poster']}')"
    conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end
  erb :info

end
