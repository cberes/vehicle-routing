class Routing
  def initialize(drivers, orders)
    @drivers = drivers
    @orders = orders
  end

  def route
    head, *tail = @drivers
    return [ { driver: head, orders: @orders } ]
  end
end

