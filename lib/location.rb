require './lib/jsonable.rb'

class Location < Jsonable
  attr_accessor :lat
  attr_accessor :lng

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def to_hash
    {lat: @lat, lng: @lng}
  end

  def self.from_hash(obj)
    Location.new(obj['lat'], obj['lng'])
  end
end
