module Kernel
  
  #
  # Syntactic sugar: xy(4,2) is shorthand for Coordinate.new(4, 2)
  #
  def xy(x, y)
    TChart::Coordinate.new(x, y)
  end

end
