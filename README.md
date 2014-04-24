[![Gem Version](https://badge.fury.io/rb/tchart.png)](http://badge.fury.io/rb/tchart)
[![Build Status](https://travis-ci.org/milewgit/tchart.png?branch=master)](https://travis-ci.org/milewgit/tchart)
[![Code Climate](https://codeclimate.com/github/milewgit/tchart.png)](https://codeclimate.com/github/milewgit/tchart)
[![Coverage Status](https://coveralls.io/repos/milewgit/tchart/badge.png?branch=master)](https://coveralls.io/r/milewgit/tchart?branch=master)



### tchart: generate TikZ code to plot date-based data

tchart is a command line utility that generates TikZ code to draw a chart of date-based data.  It is written in 
Ruby 2 and packaged as a Gem.



### Documentation

User documentation is [here](http://milewgit.github.io/tchart/).



### Branches

- **master** contains the application code.
- **gh-pages** contains the user documentation.  It is hosted on [GitHub pages](http://pages.github.com).

Releases starting from 1.0.0 have their own branches.  Older releases 0.0.1.pre and 0.0.1 are tagged.



### Code

`bin/tchart` launches the application; it simply calls TChart::run (`lib/tchart/tchart.rb`), the program entry point.



### Build

- ./_test runs all tests.
- ./_build builds the gem file.
- ./_install installs the gem file locally.



### License

Licensed under the [MIT license](LICENSE.txt).
