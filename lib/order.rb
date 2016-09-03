require './lib/jsonable.rb'
require './lib/location.rb'

class Order < Jsonable
  attr_accessor :id
  attr_accessor :origin
  attr_accessor :destination
  attr_accessor :size

  def initialize(id, origin, destination, size)
    @id = id
    @origin = origin
    @destination = destination
    @size = size
  end

  def to_hash
    {id: @id, origin: @origin, destination: @destination, size: @size}
  end

  def self.from_hash(obj)
    Order.new(obj['id'],
              Location.from_hash(obj['origin']),
              Location.from_hash(obj['destination']),
              obj['size'])
  end
end

