require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/create' do
  erb :create
end

get '/test' do
  erb :test
end

get '/no_friends' do
  erb :no_friends
end

get '/list' do
  sql = 'SELECT * FROM friends;'

  conn = PG.connect(:dbname =>'friend_list', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close

  erb :list
end

post '/create_friend' do
  if params[:name].present?
    @name = params[:name]
    @age = params[:age]
    @gender = params[:gender]
    @img = params[:img]
    @twittr = params[:twittr]
    @fb = params[:fb]

    sql = "INSERT INTO friends (name, age, gender, img, twittr, fb) VALUES ('#{@name}', '#{@age}', '#{@gender}', '#{@img}', '#{@twittr}', '#{@fb}')"
    conn = PG.connect(:dbname =>'friend_list', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end

  redirect to("/list")
end


