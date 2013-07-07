module Resume

  requirement "Write an error message to stderr when the input file is missing." do
    the_expected_errors_are 'Error: input data file /.*/ not found.'
  end
  
  requirement "When no items have date ranges, use 1st January to 31st December of the current year as the date range." do
    given_the_input "item"
    the_expected_tex_is <<-'EOS'
      % horizontal top frame
      \draw /.*/
      
      % 20/\d{2}/
      \draw /.*/
      \draw /.*/
      
      % 20/\d{2}/
      \draw /.*/
      \draw /.*/
      
      % item
    EOS
  end
  
  requirement "When an item does not have any date ranges, list the item's name on the chart but do not generate any bars." do
    given_the_input "item"
    the_expected_tex_is <<-'EOS'
      % item
      \node /.*/
      
      \endtikzpicture
    EOS
  end
  
  requirement "Write an error message when a date range's end date is before its start date." do
    given_the_input "item \t style \t 2001.1.1-2000.1.1"
    the_expected_errors_are "_test_.txt, 1: date range end 2000.1.1 before start 2001.1.1"
  end
  
  requirement "Allow date ranges to be out of order."
  
  requirement "When an item's name start with three dashes, '---', put a horizontal separator line on the chart."

end
