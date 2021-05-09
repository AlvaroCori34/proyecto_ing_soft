require 'sinatra'
require './config'

get '/' do
    erb :bienvenida
end

post '/inicio' do
    erb :inicio
end