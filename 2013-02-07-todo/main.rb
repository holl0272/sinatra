require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/faq' do
  erb :faq
end

get '/about' do
  erb :about
end

get '/create' do
  erb :create
end

get '/list' do
  sql = 'SELECT * FROM to_do_list;'

  conn = PG.connect(:dbname =>'to_do_list', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close

  erb :list
end

post '/create_task' do
  if params[:task].present?
    @tasks = params[:task]
    @descriptions = params[:description]

    sql = "INSERT INTO to_do_list (task, description) VALUES ('#{@tasks}', '#{@descriptions}')"
    conn = PG.connect(:dbname =>'to_do_list', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end
  redirect to("/")
end
