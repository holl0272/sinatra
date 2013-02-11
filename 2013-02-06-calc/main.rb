require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/calc' do
  @first = params[:first].to_f
  @second = params[:second].to_f

  @result = case params[:operator]
  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then @first * @second
  when '/' then @first / @second
  end

  erb :calc
end


# get '/calc/multiply/:num1/:num2' do
#   @result = params[:num1].to_f * params[:num2].to_f
#   erb :calc
# end

# get '/calc/add/:num1/:num2' do
#   @result = params[:num1].to_f + params[:num2].to_f
#   erb :calc
# end

# #----------------------------------------------#

# get '/name/:first/:last/:age' do
#   "your name is -> #{params[:first]} #{params[:last]} and age is #{params[:age]}"
# end

# get '/hello' do
#   'i am a master hacker ninja!!!'
#   end

# get '/' do
#   'this is the home page'
# end

# get '/eric' do
#   'eric holland'
# end