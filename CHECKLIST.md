### Committing to git
- Use a signed commit.
- Does the commit need to be built by the CI server?  Use [ci skip] if not.

### Publishing a New Version
- Is HISTORY.md up to date?
- Is lib/tchart/version.rb correct?
- Is the web site up to date?
- Is the version number correct on the project web site (<title> and in the header)?
- Is the copyright date correct on the project web site (in the footer)?
- Does the version under Installation in README match what is in lib/tchart/version.rb?
- Check git status.
- Check travis-lint.
- git push
- Force a build on travis-ci.org, if necessary; did the build pass?
- git tag -s X.Y.Z -m 'description of release'
- gem push tchart-X.Y.Z.gem
- also tag and push the web site
- Is rubygems.org showing the pushed version?
- Are the 'build' and 'gem version' badges up to date on the README in github?
- Install the gem in a clean environment and run a quick test against a small input file.
