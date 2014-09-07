[![Gem Version](https://badge.fury.io/rb/tchart.svg)](http://badge.fury.io/rb/tchart)
[![Build Status](https://travis-ci.org/milewgit/tchart.svg?branch=master)](https://travis-ci.org/milewgit/tchart)
[![Code Climate](https://codeclimate.com/github/milewgit/tchart.png)](https://codeclimate.com/github/milewgit/tchart)
[![Coverage Status](https://coveralls.io/repos/milewgit/tchart/badge.png?branch=master)](https://coveralls.io/r/milewgit/tchart?branch=master)
[![Dependencies](https://gemnasium.com/milewgit/tchart.svg)](https://gemnasium.com/milewgit/tchart)


### What is tchart?
A command line utility that generates TikZ code to draw a chart of date-based data.


### Documentation
[Here](http://milewgit.github.io/tchart.doc/) (documentation source is [here](https://github.com/milewgit/tchart.doc)).


### Development Setup

#####Requirements:
- [OS X](https://www.apple.com/osx/)
- [VMware Fusion](http://www.vmware.com/ca/en/products/fusion)
- [Vagrant](http://www.vagrantup.com)
- [Vagrant VMware provider](https://www.vagrantup.com/vmware)
- An OS X Vagrant box named OSX109 (you can use a different name by changing the BOX variable near the top of the Vagrantfile downloaded in the Install step below)

#####Install:
In a terminal window on the host machine:
```
$ mkdir -p ~/work/tchart
$ cd ~/work/tchart
$ curl -L https://raw.github.com/milewgit/tchart/master/Vagrantfile -o Vagrantfile
$ vagrant up --provider=vmware_fusion
...
```

#####Check installation:
In a terminal window on the vm (guest machine):
```
$ cd ~/Documents/tchart
$ ./_test
--------------------------------------------------------------------------------
/Library/Ruby/Gems/2.0.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:157: warning: assigned but unused variable - message
/Library/Ruby/Gems/2.0.0/gems/rest-client-1.6.7/lib/restclient/exceptions.rb:167: warning: assigned but unused variable - message
/Library/Ruby/Gems/2.0.0/gems/rest-client-1.6.7/lib/restclient/response.rb:11: warning: method redefined; discarding old body
/Library/Ruby/Gems/2.0.0/gems/rest-client-1.6.7/lib/restclient/payload.rb:47: warning: mismatched indentations at 'end' with 'case' at 40
/Library/Ruby/Gems/2.0.0/gems/simplecov-html-0.8.0/lib/simplecov-html.rb:58: warning: possibly useless use of a variable in void context
[Coveralls] Set up the SimpleCov formatter.
[Coveralls] Using SimpleCov's default settings.
Run options: --seed 6679

# Running tests:

.................................................................................................................

Finished tests in 0.094789s, 1192.1214 tests/s, 1951.7033 assertions/s.

113 tests, 185 assertions, 0 failures, 0 errors, 0 skips
[Coveralls] Outside the Travis environment, not sending data.
```

#####Uninstall:
**WARNING**: This will completely destroy the vm so you likely want to ensure that you have 
pushed any and all code changes to GitHub beforehand.

In a terminal window on the host machine:
```
$ cd ~/work/tchart
$ vagrant destroy -f
$ cd ~
$ rm -r ~/work/tchart    # and possibly rm -r ~/work if it is now empty
```


#####Development Notes:
- branch **master** contains the latest version of the application code.  Older releases starting from 1.0.0 have their own branches; releases 0.0.1.pre and 0.0.1 have tags.

- `bin/tchart` launches the application; it simply calls the program's main entry point, TChart::run (`lib/tchart.rb`).

- ./_test will run all business/unit tests.  Leave a terminal window open during development and
run ./_test as you make changes to code.

- ./_build will create the gem file tchart-1.0.1.gem

- ./_install will install the gem locally.

- If you wish to modify the Vagrantfile, it is best to do so on the host machine (~/work/tchart/Vagrantfile) 
so that you can easily do an edit/vagrant up/vagrant destroy cycle.  Once you have finished making 
changes, vagrant up and then in a terminal window on the vm do something like:
    ```
    $ cd ~/Documents/tchart
    $ cp /vagrant/Vagrantfile .
    $ git status
    ...
    $ git add Vagrantfile
    $ git commit -S -m "Insert description of change to Vagrantfile here."
    ...
    $ git push
    ...
    ```


### Thanks
- [Apple](http://www.apple.com)
- [GitHub](https://github.com), [GitHub pages](http://pages.github.com)
- [Ruby](http://www.ruby-lang.org), [RubyGems](https://rubygems.org), [rake](http://rake.rubyforge.org)
- [TeX](http://www.tug.org), [PGF/TikZ](http://sourceforge.net/projects/pgf), [MacTeX](http://tug.org/mactex)
- [TextMate](http://macromates.com), [Brackets](http://brackets.io), [iDraw](http://www.indeeo.com/idraw)
- [Travis CI](https://travis-ci.org), [Code Climate](https://codeclimate.com), [Coveralls](https://coveralls.io), [Gemnasium](https://gemnasium.com/)
- [Vagrant](https://www.vagrantup.com)
- [VMware](http://www.vmware.com)
