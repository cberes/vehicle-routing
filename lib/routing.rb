require 'set'

class Routing
  MAX_DISTANCE_IN_MILES = 5
  MAX_SMALL_ORDERS = 3

  def initialize(drivers, orders)
    @drivers = drivers
    @orders = orders
    @driver_data_by_id = Hash[@drivers.collect {
       |driver| [driver.id, { end: driver.location, cost: 0, orders: Array.new }]
    }]
    @exhausted_driver_ids = Set.new
    @assigned_order_ids = Set.new
    @unrouted = Array.new
  end

  # perform the routing algorithm
  def route
    # split large and small orders to process large orders first
    orders_by_size = @orders.partition { |order| order.large }
    # assign drivers to large orders, then small orders
    orders_by_size.each { |orders| route_all(orders) }
    { routes: @driver_data_by_id, unrouted: @unrouted }
  end

  # assign all of the orders to drivers
  def route_all(orders)
    orders_to_route = filter_new_orders(orders)
    while not orders_to_route.empty?
      route_next_order(orders_to_route)
      orders_to_route = filter_new_orders(orders)
    end
  end

  # returns orders that have not been assigned to drivers
  def filter_new_orders(orders)
    orders.reject { |order| @assigned_order_ids.include?(order.id) }
  end

  # picks the order that is nearest to a driver and assigns it if possible
  def route_next_order(orders)
    orders_with_drivers = orders.map { |order| pair_with_nearest_driver(order) }
    next_order = orders_with_drivers.min_by { |order| order[:distance] }
    assign_if_possible(next_order[:driver], next_order[:order])
    @assigned_order_ids.add(next_order[:order].id)
  end

  # returns a hash of the order, its nearest driver, and the distance between the two
  def pair_with_nearest_driver(order)
    # consider only the available drivers
    available_drivers = @drivers.reject { |driver| @exhausted_driver_ids.include?(driver.id) }
    driver = available_drivers.min_by { |driver| distance_between(driver, order) }
    driver ? { order: order, driver: driver, distance: distance_between(driver, order) } : {order: order}
  end

  # returns the distance in miles between the driver and the order
  def distance_between(driver, order)
    @driver_data_by_id[driver.id][:end].distance_to(order.origin)
  end

  # assigns the order to the driver if possible, else adds the order to the unrouted list
  def assign_if_possible(driver, order)
    if driver && valid_distance?(driver, order)
      assign(driver, order)
    else
      @unrouted.push(order.id)
    end
  end

  # assigns the order to the driver, and updates the driver (whether its exhausted and its location)
  def assign(driver, order)
    data = @driver_data_by_id[driver.id]
    data[:orders].push(order.id)
    data[:cost] += data[:end].distance_to(order.origin)
    data[:end] = order.destination
    record_exhausted_driver(driver, order)
  end

  # returns whether the distance between the driver and order is value
  def valid_distance?(driver, order)
    distance_between(driver, order) <= MAX_DISTANCE_IN_MILES
  end

  # marks the driver as exhausted if it is so
  def record_exhausted_driver(driver, order)
    if order.large || @driver_data_by_id[driver.id][:orders].length == MAX_SMALL_ORDERS
      @exhausted_driver_ids.add(driver.id)
    end
  end

  private :route_all, :filter_new_orders, :route_next_order, :assign_if_possible, :assign,
          :pair_with_nearest_driver, :distance_between, :valid_distance?, :record_exhausted_driver
end

