require './lib/jsonable.rb'
require './lib/location.rb'

class Order < Jsonable
  attr_accessor :id
  attr_accessor :origin
  attr_accessor :destination
  attr_accessor :large

  def initialize(id, origin, destination, large)
    @id = id
    @origin = origin
    @destination = destination
    @large = large
  end

  def to_hash
    {id: @id, origin: @origin, destination: @destination, large: @large}
  end

  def self.from_hash(obj)
    Order.new(obj['id'],
              Location.from_hash(obj['origin']),
              Location.from_hash(obj['destination']),
              obj['large'])
  end
end

