# routing-challenge

## Dependencies

0. json
0. sinatra

## Example Usage

    curl -v http://localhost:4567/route -XPOST \
      -d'{"drivers":[{"id":1,"location":{"lat":1,"lng":2}}],"orders":[{"id":1,"origin":{"lat":2,"lng":2},"destination":{"lat":3,"lng":4},"large":true}]}'

