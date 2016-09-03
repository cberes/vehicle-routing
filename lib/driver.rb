require './lib/jsonable.rb'
require './lib/location.rb'

class Driver < Jsonable
  attr_accessor :id
  attr_accessor :location

  def initialize(id, location)
    @id = id
    @location = location
  end

  def to_hash
    {id: @id, location: @location}
  end

  def self.from_hash(obj)
    Driver.new(obj['id'], Location.from_hash(obj['location']))
  end
end

