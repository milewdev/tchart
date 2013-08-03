module TChart
  
  requirement "The length of the x-axis is the chart width minus the y label width minus the x label width." do
    given_the_input <<-EOS
        chart_width = 130
        x_label_width = 10
        y_label_width = 20
        skill \t style \t 2001.1.1-2001.12.31
    EOS
    the_expected_tex_is <<-'EOS'
        % horizontal bottom frame
        \draw /.*/ (0.00mm, 0.00mm) -- (100.00mm, 0.00mm);
    EOS
  end
  
  
  requirement "When the items span less than a year, the x-axis date range should span one year with two labels." do
    given_the_input <<-EOS
        skill \t style \t 2001.4-2001.5
    EOS
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {2001};
        \node /.*/ {2002};

        % vertical grid lines
    EOS
  end
  
  
  requirement "When the items span exactly one year, the x-axis date range should span one year with two labels." do  
    given_the_input <<-EOS
        skill \t style \t 2001.1.1-2001.12.31
    EOS
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {2001};
        \node /.*/ {2002};

        % vertical grid lines
    EOS
  end
  
  
  requirement "When the items span less than 10 years, the x-axis labels should be one year apart." do  
    given_the_input <<-EOS
        skill \t style \t 2001.1.1-2004.1.1
    EOS
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {2001};
        \node /.*/ {2002};
        \node /.*/ {2003};
        \node /.*/ {2004};
        \node /.*/ {2005};

        % vertical grid lines
    EOS
  end
  
  
  requirement "When the items span more than 10 years but less than 50 years, the x-axis date labels should be 5 years apart." do  
    given_the_input <<-EOS
        skill \t style \t 2001.1.1-2011.1.1
    EOS
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {2000};
        \node /.*/ {2005};
        \node /.*/ {2010};
        \node /.*/ {2015};

        % vertical grid lines
    EOS
  end
  
  
  requirement "When the items span more than 50 years, the x-axis date labels should be one decade apart." do  
    given_the_input <<-EOS
        skill \t style \t 2001.1.1-2051.1.1
    EOS
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {2000};
        \node /.*/ {2010};
        \node /.*/ {2020};
        \node /.*/ {2030};
        \node /.*/ {2040};
        \node /.*/ {2050};
        \node /.*/ {2060};

        % vertical grid lines
    EOS
  end
  
  # OLD

  requirement "Write an error message to stderr when the input file is missing." do
    the_expected_errors_are 'Error: input data file /.*/ not found.'
  end
  
  requirement "When no items have date ranges, use 1st January to 31st December of the current year as the date range." do
    given_the_input "item"
    the_expected_tex_is <<-'EOS'
        % x-axis labels
        \node /.*/ {20/\d{2}/};
        \node /.*/ {20/\d{2}/};
      
        % vertical grid lines
    EOS
  end
  
  requirement "When an item does not have any date ranges, list the item's name on the chart but do not generate any bars." do
    given_the_input "item"
    the_expected_tex_is <<-'EOS'
        \draw [vgridline] /.*/
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
