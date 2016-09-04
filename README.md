# routing-challenge

## Dependencies

0. json
0. sinatra

## Example Usage

    curl -v http://localhost:4567/route -XPOST -d'{"drivers":[
    {"id":1,"location":{"lat":0.01,"lng":0.01}},
    {"id":2,"location":{"lat":0.04,"lng":0.05}},
    {"id":3,"location":{"lat":0.09,"lng":0.01}}
    ],"orders":[
    {"id":1,"origin":{"lat":0.01,"lng":0.02},"destination":{"lat":0.03,"lng":0.05},"large":true},
    {"id":2,"origin":{"lat":0.02,"lng":0.01},"destination":{"lat":0.08,"lng":0.01},"large":false},
    {"id":3,"origin":{"lat":0.04,"lng":0.04},"destination":{"lat":0.02,"lng":0.02},"large":false},
    {"id":4,"origin":{"lat":0.02,"lng":0.00},"destination":{"lat":0.04,"lng":0.02},"large":false},
    {"id":5,"origin":{"lat":0.04,"lng":0.02},"destination":{"lat":0.09,"lng":0.03},"large":false},
    {"id":6,"origin":{"lat":0.10,"lng":0.00},"destination":{"lat":0.10,"lng":0.03},"large":false}
    ]}'

