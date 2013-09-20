<!-- build status and gem version badges -->
[![Build Status](https://travis-ci.org/milewgit/tchart.png?branch=master)](https://travis-ci.org/milewgit/tchart)
<br>
[![Gem Version](https://badge.fury.io/rb/tchart.png)](http://badge.fury.io/rb/tchart)



### tchart: generate TikZ code to plot date-based data

tchart is a command line utility that generates TikZ code to draw a chart of date-based data.  It is written in 
Ruby 2 and packaged as a Gem.



### Documentation

User documentation is [here](http://milewgit.github.io/tchart/).



### Branches

- **master** contains the application code.
- **gh-pages** contains the project website.  It is hosted on [GitHub pages](http://pages.github.com).

Releases are tagged and are of the form 0.0.1.pre, 0.0.1, etc.



### Code

- `bin/tchart` launches the application.
- **TChart** is the main module.
- **TChart::run** (`lib/tchart/tchart.rb`) is the program entry point.



### Build

- `$ rake test` runs all tests.
- `$ rake build` builds the gem file.
- `$ rake install` installs the gem file locally.
- `$ rake all` runs test, build, and install. 
- `$ rake` is the same as `$ rake test`.



### License

Licensed under the [MIT license](LICENSE.txt).
