require 'pry'
require 'yahoofinance'
require 'sinatra'
require 'sinatra/reloader' if development?


get '/iquote' do
  if params[:symbol].nil?
    @symbol = 'AOL'
  else
    @symbol = params[:symbol]
  end
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @symbol)[@symbol].lastTrade
  erb :stock
end
