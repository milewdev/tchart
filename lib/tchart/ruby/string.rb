class String
  
  #
  # Insert 'amount' spaces at the beginning of all non-empty lines.  
  #
  # A line is considered empty if it consists only of zero or more 
  # space and/or tab characters.
  #
  def indent(amount)
    indent = " " * amount
    self.each_line
      .map { |line| line.strip.length > 0 ? "#{indent}#{line}" : line }
      .join
  end

  #
  # Remove spaces from the beginning of all non-empty lines.  Each line is
  # unindented by the same amount, that being number of spaces of the least
  # indented line.  For example, " a\n  b" => "a\n b"; the first line is 
  # indented by one space, the second by two spaces, so both are unindented
  # by one space.
  #
  # Note: tabs in the leading whitespace are not supported.
  #
  def unindent
    raise Exception, "String#unindent does not support tabs in the leading whitespace" if match( /^ *\t/ )
    shortest_indent = each_line
      .select { |line| line.strip.length > 0 }
      .inject(self.length) { |min, line| [ min, /^( *)/.match(line)[1].length ].min }
    each_line
      .map { |line| line.strip.length > 0 ? line[shortest_indent..-1] : line }
      .join
  end

end
