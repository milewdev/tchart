require_relative '../../test_helper'

module TChart
  describe DataParser do
    
    it "reads all lines from the data source" do
      data = StringIO.new("1\n2\n3\n")
      DataParser.parse('filename.txt', data)
    end
    
    it "ignores blank lines" do
      data = StringIO.new("1\n \n3\n")
      _, items, _ = DataParser.parse('filename.txt', data)
      items.map { |item| item.description }.must_equal(['1', '3'])
    end
    
    it "ignores empty lines" do
      data = StringIO.new("1\n\n3\n")
      _, items, _ = DataParser.parse('filename.txt', data)
      items.map { |item| item.description }.must_equal(['1', '3'])
    end
    
    it "ignores comment lines" do
      data = StringIO.new("1\n# comment\n3\n")
      _, items, _ = DataParser.parse('filename.txt', data)
      items.map { |item| item.description }.must_equal(['1', '3'])
    end
    
    it "ignores trailing comments" do
      data = StringIO.new("1\n2 # comment\n3\n")
      _, items, _ = DataParser.parse('filename.txt', data)
      items.map { |item| item.description }.must_equal(['1', '2', '3'])
    end
    
    it "does not treat escaped hashes (#) as comments" do
      data = StringIO.new("C\\#\n")
      _, items, _ = DataParser.parse('filename.txt', data)
      items[0].description.must_equal 'C#'
    end
    
    it "include the data source name and line number in error messages" do
      data = StringIO.new("unknown_setting_name = 42\n")
      _, _, errors = DataParser.parse('filename.txt', data)
      errors.find {|item| item =~ /^filename.txt, 1:/}.wont_be_nil
    end
    
    it "returns a 'no items found' error if no items were found in the data and no other errors were found" do
      data = StringIO.new("# no chart items\n")
      _, _, errors = DataParser.parse('filename.txt', data)
      errors.must_equal [ "filename.txt: no items found" ]
    end
    
    it "does not return a 'no items found' error if no items were found in the data but other errors were found" do
      data = StringIO.new("unknown_setting = 123\n")
      _, _, errors = DataParser.parse('filename.txt', data)
      errors.wont_include [ "filename.txt: no items found" ]
    end
    
  end
end
