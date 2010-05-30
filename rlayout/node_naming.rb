
module RLayout

  # Derive node name using _converter_ and possible arguments _param_
  def RLayout.derive_name(converter, *arg)
    case converter
      when String then converter
      when Proc then converter.call(*arg).to_s
    end
  end
  
end
