### Publishing a New Version
- Is HISTORY.md up to date?
- Is lib/tchart/version.rb correct?
- Check git status.
- Check travis-lint.
- Force a build on travis-ci.org; did the build pass?
- git tag -s X.Y.Z -m 'description of release'
- gem push tchart-X.Y.Z.gem
- Is rubygems.org showing the pushed version?
- Are the 'build' and 'gem version' badges up to date on the README in github?
