require './lib/jsonable.rb'

class Location < Jsonable
  attr_accessor :lat
  attr_accessor :lng

  EARTH_RADIUS_IN_MILES = 3959

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def distance_to(other)
    # find haversine distance between points
    phi_1 = to_radians(@lat)
    phi_2 = to_radians(other.lat)
    phi_d = to_radians(other.lat - @lat)
    lambda_d = to_radians(other.lng - @lng)
    a = Math.sin(phi_d / 2) ** 2 + Math.cos(phi_1) * Math.cos(phi_2) * Math.sin(lambda_d / 2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    c * EARTH_RADIUS_IN_MILES
  end

  def to_radians(deg)
    deg * Math::PI / 180
  end

  def to_hash
    {lat: @lat, lng: @lng}
  end

  def self.from_hash(obj)
    Location.new(obj['lat'], obj['lng'])
  end

  private :to_radians
end

