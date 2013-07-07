class String
  def blank_to_nil
    return self unless strip.length == 0
    nil
  end
end
