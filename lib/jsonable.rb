class Jsonable
  def to_json(options = {})
    to_hash.to_json(options)
  end

  def to_hash
    raise "Must implement to_hash"
  end
end

