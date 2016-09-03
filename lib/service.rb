require 'sinatra'
require 'json'

require './lib/driver.rb'
require './lib/order.rb'
require './lib/routing.rb'

post '/route' do
  request.body.rewind
  payload = JSON.parse request.body.read
  drivers = payload['drivers'].map { |d| Driver.from_hash(d) }
  orders = payload['orders'].map { |d| Order.from_hash(d) }
  return Routing.new(drivers, orders).route.to_json
end
