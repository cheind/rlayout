
module RLayout

  # Derive node name using +converter+ and possible arguments +args+
  # If converter is a string the converter is assumed ot be a constant function
  # returning that string.
  def RLayout.derive_name(converter, *args)
    result = nil
    case converter
      when String then result = converter
      when Proc then result = converter.call(*args).to_s
    end
    result
  end
  
end
