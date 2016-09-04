require 'set'

class Routing
  MAX_DISTANCE_IN_MILES = 5

  def initialize(drivers, orders)
    @drivers = drivers
    @orders = orders
    @driver_locations_by_id = Hash[@drivers.collect { |driver| [driver.id, driver.location] }]
    @exhausted_drivers_ids = Set.new
    @assignments = Hash.new
  end

  def route
    # sort orders so large orders appear first
    @orders.sort_by { |order| order.large ? 0 : 1 }
    # then assign a driver to each order
    @orders.each { |order| assign(order) }
    @assignments
  end

  def assign(order)
    available_drivers = @drivers.reject { |driver| @exhausted_drivers_ids.include?(driver.id) }
    driver = available_drivers.min_by { |driver| @driver_locations_by_id[driver.id].distance_to(order.origin) }
    validate_distance(driver, order)
    add_assignment(driver, order)
    record_exhausted_driver(driver, order)
    @driver_locations_by_id[driver.id] = order.destination
  end

  def validate_distance(driver, order)
    best_distance = @driver_locations_by_id[driver.id].distance_to(order.origin)
    if best_distance > MAX_DISTANCE_IN_MILES
      raise "Order #{order.id} not routable. Distance #{best_distance} > #{MAX_DISTANCE_IN_MILES}"
    end
  end

  def add_assignment(driver, order)
    if @assignments.include?(driver.id)
      @assignments[driver.id].push(order.id)
    else
      @assignments[driver.id] = [order.id]
    end
  end 

  def record_exhausted_driver(driver, order)
    if order.large || @assignments[driver.id].length == 3
      @exhausted_drivers_ids.add(driver.id)
    end
  end

  private :assign, :validate_distance, :add_assignment, :record_exhausted_driver
end

