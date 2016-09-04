require './lib/driver.rb'
require './lib/location.rb'
require './lib/order.rb'
require './lib/routing.rb'

describe Routing do
  it "routes 3 orders in a line" do
    drivers = [Driver.new(1, Location.new(0.01, 0.01))]
    orders = [Order.new(3, Location.new(0.01, 0.03), Location.new(0.01, 0.04), false),
              Order.new(2, Location.new(0.01, 0.02), Location.new(0.01, 0.03), false),
              Order.new(1, Location.new(0.01, 0.01), Location.new(0.01, 0.02), false)]
    routes = Routing.new(drivers, orders).route[:routes]
    expect(routes.length).to eq(1)
    expect(routes[1][:orders]).to eq([1, 2, 3])
    expect(routes[1][:cost]).to eq(0)
    expect(routes[1][:end]).to eq(orders[0].destination)
  end

  it "routes large orders first" do
    drivers = [Driver.new(1, Location.new(0.01, 0.01)),
               Driver.new(2, Location.new(0.05, 0.05))]
    orders = [Order.new(1, Location.new(0.01, 0.03), Location.new(0.01, 0.02),  true),
              Order.new(2, Location.new(0.01, 0.02), Location.new(0.01, 0.03), false),
              Order.new(3, Location.new(0.02, 0.03), Location.new(0.04, 0.04), false)]
    routes = Routing.new(drivers, orders).route[:routes]
    expect(routes.length).to eq(2)
    expect(routes[1][:orders]).to eq([1])
    expect(routes[2][:orders]).to eq([3, 2])
  end

  it "will not route trips > 5 miles away" do
    drivers = [Driver.new(1, Location.new(0.01, 0.01))]
    orders = [Order.new(1, Location.new(1.01, 1.01), Location.new(1.05, 1.05),  true)]
    result = Routing.new(drivers, orders).route
    expect(result[:routes][1][:orders].length).to eq(0)
    expect(result[:unrouted].length).to eq(1)
  end

  it "routes at most 3 routes per driver" do
    drivers = [Driver.new(1, Location.new(0.01, 0.01)),
               Driver.new(2, Location.new(0.05, 0.05))]
    orders = [Order.new(1, Location.new(0.01, 0.01), Location.new(0.02, 0.02), false),
              Order.new(2, Location.new(0.02, 0.02), Location.new(0.02, 0.00), false),
              Order.new(3, Location.new(0.02, 0.00), Location.new(0.01, 0.01), false),
              Order.new(4, Location.new(0.02, 0.01), Location.new(0.01, 0.01), false)]
    routes = Routing.new(drivers, orders).route[:routes]
    expect(routes[1][:orders]).to eq([1, 2, 3])
    expect(routes[2][:orders]).to eq([4])
  end

  it "routes a more complicated example" do
    drivers = [Driver.new(1, Location.new(0.01, 0.01)),
               Driver.new(2, Location.new(0.04, 0.05)),
               Driver.new(3, Location.new(0.09, 0.01))]
    orders = [Order.new(1, Location.new(0.01, 0.02), Location.new(0.03, 0.05),  true),
              Order.new(2, Location.new(0.02, 0.01), Location.new(0.03, 0.01), false),
              Order.new(3, Location.new(0.04, 0.04), Location.new(0.02, 0.02), false),
              Order.new(4, Location.new(0.09, 0.02), Location.new(0.04, 0.02), false),
              Order.new(5, Location.new(0.04, 0.02), Location.new(0.09, 0.03), false),
              Order.new(6, Location.new(0.10, 0.00), Location.new(0.10, 0.03), false)]
    routes = Routing.new(drivers, orders).route[:routes]
    expect(routes[1][:orders]).to eq([1])
    expect(routes[2][:orders]).to eq([3, 2])
    expect(routes[3][:orders]).to eq([4, 5, 6])
  end
end

