<!-- build status and gem version badges -->
[![Build Status](https://travis-ci.org/milewgit/tchart.png)](https://travis-ci.org/milewgit/tchart)
<br>
[![Gem Version](https://badge.fury.io/rb/tchart.png)](http://badge.fury.io/rb/tchart)



### tchart: generate TikZ code to chart date-based data

tchart is a command line utility that generates [TikZ](http://sourceforge.net/projects/pgf/)
code to draw a chart of date-based data.

For example, a file containing:

<!-- @tchart doc/README/overview.jpg -->
```
Objective-C  | lang | 2006.6 - 2013.7
C++          | lang | 2002 - 2008
C            | lang | 2001 - 2002 | 2005 - 2007
-----------------------------------------------
PostgreSQL   | db   | 2004 - 2006
SQLite       | db   | 2002 - 2007
-----------------------------------------------
OS X         | os   | 2006.6 - 2013.7
Linux        | os   | 2005 - 2010
Windows      | os   | 2001 - 2006.2
-----------------------------------------------
XCode        | tool | 2006.6 - 2013.7
Emacs        | tool | 2005 - 2008
VS           | tool | 2001 - 2004
```
<!-- @end -->

will result in the chart:

![overview.jpg](doc/README/overview.jpg)



<br>
### Requirements
- [Ruby 2.0](https://www.ruby-lang.org)
- a TeX installation (e.g. [MacTeX](http://tug.org/mactex)) to render generated charts



<br>
### Installation

```
$ gem install tchart --pre
```



<br>
### Quick Start

1.  Create an input file, skills.txt, containing some date-based data:

    <!-- @tchart doc/README/tutorial.jpg -->    
    ```
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->

2.  Run tchart to read skills.txt and write generated TikZ code to skills.tikz:

    ```
    $ tchart skills.txt skills.tikz
    ```

3.  The generated TikZ code references a style name we specified in skills.txt ('lang'),
    as well as styles for the x axis labels ('xlabel'), the y axis labels ('ylabel'),
    and the chart grid lines ('gridline').  Create a TeX document, styles.tikz, that 
    defines these styles:
    
    ```
    % Style for x axis labels.
    \tikzset{ xlabel/.style = {
      text width = 10.00mm,
      align = center,
      inner sep = 0
    }}
    
    % Style for y axis labels.
    \tikzset{ ylabel/.style = {
      minimum height = 4.60mm,
      text width = 24.00mm,
      text depth = 0.5mm,
      align = left,
      inner sep = 0
    }}
    
    % Style for grid lines.
    \tikzset{ gridline/.style = {
      draw = black!20
    }}
    
    % Style for programming language ('lang') bars.
    \definecolor{lang_color}{rgb}{.10, .32, .68}
    \tikzset{ lang/.style = {
      rounded corners = 1mm,
      line width = 0.1pt,
      draw = lang_color,
      top color = lang_color,
      bottom color = lang_color
    }}
    ```
    
    See [pgfmanual.pdf](http://mirrors.ctan.org/graphics/pgf/base/doc/generic/pgf/pgfmanual.pdf)
    for more information on TikZ and styles (e.g. sections 2.8, 12.4.2, and 55.4.4).
    
4.  Create a main TeX document, skills.tex, that includes ('\input's) the TikZ library, the 
    styles.tikz file, and the generated skills.tikz file:
    
    ```
    \def\pgfsysdriver{pgfsys-pdftex.def}
    \input tikz.tex
    \usetikzlibrary{positioning, shapes.misc}
    \parindent = 0in
    \input styles.tikz
    \input skills.tikz
    \end
    ```

5.  Generate a PDF file from skills.tex:

    ```
    $ pdftex -interaction=batchmode skills.tex
    ```
    
    [pdftex](http://www.tug.org/applications/pdftex/) will generate the file skills.pdf, which
    looks like this:

    ![tutorial.jpg](doc/README/tutorial.jpg)



<br>
### Usage

```
$ tchart [ --help | --version | input-data-filename output-tikz-filename ]
```

--help prints a usage message and exits.  -h can also be used.

--version prints the tchart version and exits.  -v can also be used.

input-data-filename is the name of a file containing date-based data, and output-tikz-filename
is the name of the a file where generated TikZ code should be written.  If output-tikz-filename
already exists, it will be silently overwritten.  Both file names must be specified.

There are no restrictions on the file names other than those imposed by the operating system.
Although the examples here use .txt and .tikz as the extensions of the input and output files,
you can use any extensions you like (or none at all).

Examples:

```
$ tchart --help
Usage: tchart [ --version | --help | input-data-filename output-tikz-filename ]

$ tchart -h
Usage: tchart [ --version | --help | input-data-filename output-tikz-filename ]

$ tchart --version
1.0.0

$ tchart skills.txt
Usage: tchart [ --version | --help | input-data-filename output-tikz-filename ]

$ tchart skills.txt skills.tikz
$ 
```



<br>
### Data File Format

Input files consist of one or more lines where each line can be a comment, a blank line, a data
line, a separator line, or a setting:

<!-- @tchart doc/README/data-file-format.jpg -->
```
# A comment.

# There are blanks lines above and below this line, and further down.

# A data line.
Objective-C  | lang | 2006.6 - 2013.8

# A separator line.
-------------------------------------

# A setting.
chart_width = 164.99
```
<!-- @end -->

![data-file-format.jpg](doc/README/data-file-format.jpg)


<br>
##### Comments

Only line comments are supported (as opposed to multi-line block comments, such as C's /* ... */).  
A comment can appear either on a line by itself or at the end of a line.  The comment delimiter is #.

<!-- @tchart doc/README/comments.jpg -->
```
# This is a comment.
Objective-C  | lang | 2006.6 - 2013.7               # This is another comment.
C++          | lang | 2002 - 2008
# C            | lang | 2001 - 2002 | 2005 - 2007     # This line is commented out.
```
<!-- @end -->

![comments.jpg](doc/README/comments.jpg)


<br>
##### Blank Lines

Blank lines are ignored.


<!-- @tchart doc/README/blank-lines.jpg -->
```
Objective-C  | lang | 2006.6 - 2013.7

C++          | lang | 2002 - 2008

C            | lang | 2001 - 2002 | 2005 - 2007
```
<!-- @end -->

![blank-lines.jpg](doc/README/blank-lines.jpg)


<br>
##### Data Lines

A data line represents something, a subject, that has a set of date ranges to be plotted on a row
on the chart.  For example, I may have written C++ programs from 2001 to 2003, and 2004 to 2007,
and I would like to plot this.  C++ is the subject of the row, and 2001 to 2003, and 2004 to 2007
are two date ranges that will appear as bars on the row.

A data line contains a description of the subject, which becomes the y axis label on the chart,
a style that defines how to draw the date range bars (i.e. what colour and shape the bars should
be, etc.), and one or more date ranges.  Elements are separated by a pipe character (|).

<!-- @tchart doc/README/data-lines.jpg -->
```
C            | lang | 2001 - 2002 | 2005 - 2007
```
<!-- @end -->

![data-lines.jpg](doc/README/data-lines.jpg)


<br>
##### Data Line Descriptions

Descriptions can contain spaces, although leading and trailing spaces are ignored.

<!-- @tchart doc/README/data-line-descriptions.jpg -->
```
# The description below has leading, trailing, and embedded spaces.
   C & C++   | lang | 2001 - 2008       # The label used on the chart is "C & C++"
```
<!-- @end -->

![data-lines-descriptions.jpg](doc/README/data-line-descriptions.jpg)


The tchart special characters # (hash, starts a comment) and | (pipe, field separator) can be 
used in descriptions by escaping them with a \ (back slash).  \ can be used by escaping it 
with another \ .

<!-- @tchart doc/README/data-line-escaping.jpg -->
```
C\#         | lang | 2001 - 2007
Bo\|\|ean   | lang | 2003 - 2005
Back\\slash | lang | 2004 - 2008
```
<!-- @end -->

![data-lines-escaping.jpg](doc/README/data-line-escaping.jpg)


<br>
##### Data Line Styles

The bar style is the name of a TikZ style that must be defined in the TeX document that contains
the generated TikZ chart code.  For example, we might have a file, chart.txt, that contains:

<!-- @tchart doc/README/data-line-styles.jpg -->
```
C++          | lang | 2002 - 2008
Linux        | os   | 2005 - 2010
```
<!-- @end -->

The TeX document that includes the chart code must define the 'lang' and 'os' TikZ styles, perhaps 
by incuding a separate file, or inline, as shown here:

```
...

% Style for programming language chart bars.
\definecolor{lang_color}{rgb}{ 0.59, 0.59, 0.39 }
\tikzset{ lang/.style = {
  rounded corners = 1mm,
  line width = 0.1pt,
  draw = lang_color,
  top color = lang_color,
  bottom color = lang_color
}}

% Style for operating systems chart bars.
\definecolor{os_color}{rgb}{0.88, 0.88, 0.59}
\tikzset{ os/.style = {
  rounded corners = 1mm,
  line width = 0.1pt,
  draw = os_color,
  top color = os_color,
  bottom color = os_color
}}

...

\input chart.tikz

...
```

![data-lines-styles.jpg](doc/README/data-line-styles.jpg)

More information on TikZ styles can be found in [pgfmanual.pdf](http://mirrors.ctan.org/graphics/pgf/base/doc/generic/pgf/pgfmanual.pdf), in particular sections 2.8, 12.4.2, and 55.4.4.


<br>
##### Data Line Dates

Date ranges can be specified in various ways:

<!-- @tchart doc/README/data-line-dates.jpg -->
```
2001.3.14 - 2001.11.22  | lang | 2001.3.14 - 2001.11.22   # date format is yyyy.mm.dd
2001.3.14-2001.11.22    | lang | 2001.3.14-2001.11.22     # spaces around the '-' are optional
2001.3 - 2001.11.22     | lang | 2001.3 - 2001.11.22      # same as: 2001.3.1 - 2001.11.22
2001 - 2001.11.22       | lang | 2001 - 2001.11.22        # 2001.1.1 - 2001.11.22
2001.3.14 - 2001.11     | lang | 2001.3.14 - 2001.11      # 2001.3.14 - 2001.11.30
2001.3.14 - 2001        | lang | 2001.3.14 - 2001         # 2001.3.14 - 2001.12.31
2001.3.14               | lang | 2001.3.14                # 2001.3.14 - 2001.3.4
2001.3                  | lang | 2001.3                   # 2001.3.1 - 2001.3.31
2001                    | lang | 2001                     # 2001.1.1 - 2001.12.31

# make more room for the those long y axis labels, a setting that is described later
y_axis_label_width = 40
```
<!-- @end -->

![data-lines-dates.jpg](doc/README/data-line-dates.jpg)

Dates are optional and if omitted result in the description appearing on the chart without 
any bars.  If no dates are supplied, then the style may be omitted as well, although it 
will be ignored if included.

<!-- @tchart doc/README/data-line-dates-optional.jpg -->
```
Objective-C  | lang | 2006.6 - 2013.7
C++          | lang
C
``` 
<!-- @end -->

![data-lines-dates-optional.jpg](doc/README/data-line-dates-optional.jpg)

The labels on the x axis are determined by the range of dates found in the data:

<!-- @tchart doc/README/data-line-dates-range1.jpg -->
```
Every Year | lang | 2000 - 2009
```
<!-- @end -->

![data-line-dates-range1.jpg](doc/README/data-line-dates-range1.jpg)


<!-- @tchart doc/README/data-line-dates-range5.jpg -->
```
Every 5 Years | lang | 2000 - 2049
```
<!-- @end -->

![data-line-dates-range1.jpg](doc/README/data-line-dates-range5.jpg)


<!-- @tchart doc/README/data-line-dates-range10.jpg -->
```
Every 10 Years | lang | 2000 - 2050
```
<!-- @end -->

![data-line-dates-range1.jpg](doc/README/data-line-dates-range10.jpg)


<br>
##### Separator Lines

Separator lines are used to break subjects into sections by drawing a horizontal grid 
line on the chart.  They are specified by using a line starting with three dashes (minus signs), ---.

<!-- @tchart doc/README/separator-line.jpg -->
```
Objective-C  | lang | 2006.6 - 2013.7
---                                     # Three dashes produce a separator.
PostgreSQL   | db   | 2004 - 2006
--- Anything after the first three dashes is ignored, so this is legal.
OS X         | os   | 2006.6 - 2013.7
-------------------------------------   # A full line of dashes.
XCode        | tool | 2006.6 - 2013.7
```
<!-- @end -->

![separator-line.jpg](doc/README/separator-line.jpg)


<br>
##### Settings

tchart makes no attempt to determine how much space text in the generated chart occupies and so
it uses default values for the overall width of the chart, the length of the y axis labels, and
so on.  These default values can be overridden in the data file using settings.  Settings are
of the form:

```
name = value
```

Spaces before and after 'name' and 'value' are ignored.  The following two lines are equivalent:

```
chart_width=164.99
  chart_width   =   164.99
```

Settings can appear anywhere in the data file, although putting them at the top is likely the best
idea.  If the same setting is specified more than once, the last value listed is the one that is
used:

```
chart_width = 100
chart_width = 80
chart_width = 60        # This is the winning value.
```

<br>

-   **chart_width** (default 164.99mm) specifies the overall width of the chart.  This includes
    the y axis labels, the margins to the left and right of the x axis (the plot area), and the
    length of the x axis:

    <!-- @tchart doc/README/chart-width-narrow.jpg -->
    ```
    chart_width = 70

    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->

    ![chart-width-narrow.jpg](doc/README/chart-width-narrow.jpg)

    <!-- @tchart doc/README/chart-width-wide.jpg -->
    ```
    chart_width = 140

    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->

    ![chart-width-wide.pjg](doc/README/chart-width-wide.jpg)


<br>

-   **line_height** (default 4.6mm) specifies the height of each row in the chart:

    <!-- @tchart doc/README/line-height-small.jpg -->
    ```
    line_height = 3
    
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![line-height-small.jpg](doc/README/line-height-small.jpg)

    <!-- @tchart doc/README/line-height-large.jpg -->
    ```
    line_height = 9
    
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![line-height-large.jpg](doc/README/line-height-large.jpg)


<br>

-   **x_axis_label_width** (default 10mm) specifies the width of the x axis labels.
    It is used by tchart to calculate the left and right margins around the plot
    area only (each margin is 1/2 x_axis_label_width):
    
    <!-- @tchart doc/README/x-axis-label-width-small.jpg -->
    ```
    x_axis_label_width = 10
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![x-label-width.jpg](doc/README/x-axis-label-width-small.jpg)
    
    <!-- @tchart doc/README/x-axis-label-width-large.jpg -->
    ```
    x_axis_label_width = 50
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![x-axis-label-width.jpg](doc/README/x-axis-label-width-large.jpg)
    
    
<br>

-   **x_axis_label_y_coordinate** (default -3mm) specifies the distance from the x axis
    that the center of the x axis labels appear at:
    
    <!-- @tchart doc/README/x-axis-label-y-coordinate-above.jpg -->
    ```
    x_axis_label_y_coordinate = 10
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![x-axis-label-y-coordinate-above.jpg](doc/README/x-axis-label-y-coordinate-above.jpg)
    
    <!-- @tchart doc/README/x-axis-label-y-coordinate-below.jpg -->
    ```
    x_axis_label_y_coordinate = -10
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![x-axis-label-y-coordinate-below.jpg](doc/README/x-axis-label-y-coordinate-below.jpg)


<br>

-   **y_axis_label_width** (default 24mm) specifies the width of the y axis labels
    (the black marks after 'Objective-' and 'C++' in the chart below are generated 
    by TeX to indicate that text, for example, is too long for the space allocated
    for it):

    <!-- @tchart doc/README/y-axis-label-width-narrow.jpg -->
    ```
    y_axis_label_width = 5
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![y-axis-label-width-narrow.jpg](doc/README/y-axis-label-width-narrow.jpg)

    <!-- @tchart doc/README/y-axis-label-width-wide.jpg -->
    ```
    y_axis_label_width = 50    
        
    Objective-C  | lang | 2006.6 - 2013.7
    C++          | lang | 2002 - 2008
    C            | lang | 2001 - 2002 | 2005 - 2007
    ```
    <!-- @end -->
    
    ![y-axis-label-width-wide.jpg](doc/README/y-axis-label-width-wide.jpg)



<br>
### Copyright Notices

[TeX](http://www.tug.org) is a typesetting system invented by Donald Knuth.

[PGF/TikZ](http://sourceforge.net/projects/pgf/) is a system designed by Till Tantau for producing graphics in TeX and similar documents.

[Ruby](http://www.ruby-lang.org) is a programming language initially designed and developed by Yukihiro Matsumoto.

[OS X](http://www.apple.com/osx/) is a trademark of Apple Inc.

All other company and/or product names may be the property of and/or trademarks of their respective owners.
