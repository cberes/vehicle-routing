# vehicle-routing

A greedy solution for the Vehicle Routing Problem.

## Conditions

0. Drivers start in different locations.
0. There is no mandate that drivers return to their origin locations.
0. Orders can be small or large. A driver can take at most 3 small orders or 1 large order.
0. Drivers cannot be assigned to orders that are more than 5 miles away.

## Dependencies

0. json
0. sinatra
0. rspec (tests)

## Run the service

    ruby lib/service.rb

## Run tests

    rspec tests

## Example Usage

### Routes all orders

    curl -v http://localhost:4567/route -XPOST -d'{"drivers":[
    {"id":1,"location":{"lat":0.01,"lng":0.01}},
    {"id":2,"location":{"lat":0.04,"lng":0.05}},
    {"id":3,"location":{"lat":0.09,"lng":0.01}}
    ],"orders":[
    {"id":1,"origin":{"lat":0.01,"lng":0.02},"destination":{"lat":0.03,"lng":0.05},"large":true},
    {"id":2,"origin":{"lat":0.02,"lng":0.01},"destination":{"lat":0.03,"lng":0.01},"large":false},
    {"id":3,"origin":{"lat":0.04,"lng":0.04},"destination":{"lat":0.02,"lng":0.02},"large":false},
    {"id":4,"origin":{"lat":0.09,"lng":0.02},"destination":{"lat":0.04,"lng":0.02},"large":false},
    {"id":5,"origin":{"lat":0.04,"lng":0.02},"destination":{"lat":0.09,"lng":0.03},"large":false},
    {"id":6,"origin":{"lat":0.10,"lng":0.00},"destination":{"lat":0.10,"lng":0.03},"large":false}
    ]}'

### Does not route one order

    curl -v http://localhost:4567/route -XPOST -d'{"drivers":[
    {"id":1,"location":{"lat":0.01,"lng":0.01}},
    {"id":2,"location":{"lat":0.04,"lng":0.05}},
    {"id":3,"location":{"lat":0.09,"lng":0.01}}
    ],"orders":[
    {"id":1,"origin":{"lat":0.01,"lng":0.02},"destination":{"lat":0.03,"lng":0.05},"large":true},
    {"id":2,"origin":{"lat":0.02,"lng":0.01},"destination":{"lat":0.03,"lng":0.01},"large":false},
    {"id":3,"origin":{"lat":0.04,"lng":0.04},"destination":{"lat":0.02,"lng":0.02},"large":false},
    {"id":4,"origin":{"lat":0.02,"lng":0.00},"destination":{"lat":0.04,"lng":0.02},"large":false},
    {"id":5,"origin":{"lat":0.04,"lng":0.02},"destination":{"lat":0.09,"lng":0.03},"large":false},
    {"id":6,"origin":{"lat":0.10,"lng":0.00},"destination":{"lat":0.10,"lng":0.03},"large":false}
    ]}'

### Routes three orders in a line

    curl -v http://localhost:4567/route -XPOST -d'{"drivers":[
    {"id":1,"location":{"lat":0.01,"lng":0.01}}
    ],"orders":[
    {"id":3,"origin":{"lat":0.01,"lng":0.03},"destination":{"lat":0.01,"lng":0.04},"large":false},
    {"id":2,"origin":{"lat":0.01,"lng":0.02},"destination":{"lat":0.01,"lng":0.03},"large":false},
    {"id":1,"origin":{"lat":0.01,"lng":0.01},"destination":{"lat":0.01,"lng":0.02},"large":false}
    ]}'

