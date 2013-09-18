class Hash
  def camelize_keys_lower
    Hash[self.map {|k, v| [k.camelize(:lower) , v] }]
  end
end
