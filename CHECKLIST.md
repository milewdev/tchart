### Publishing a New Version
- Is HISTORY.md up to date?
- Is lib/tchart/version.rb correct?
- Does the version under Installation in README match what is in lib/tchart/version.rb?
- Check git status.
- Check travis-lint.
- Force a build on travis-ci.org; did the build pass?
- git tag -s X.Y.Z -m 'description of release'
- gem push tchart-X.Y.Z.gem
- Is rubygems.org showing the pushed version?
- Are the 'build' and 'gem version' badges up to date on the README in github?
- Install the gem in a clean environment and run a quick test against a small input file.