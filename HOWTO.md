### Sign a commit
```Shell
$ git commit -S -m 'Description of the commit.'

# show the signatures
$ git log --show-signature
```


<br>


### Tag a release
```Shell
# -s signs the tag
$ git tag -s x.y.z -m 'Description of the release.'
$ git push origin x.y.z

# list the tags
$ git tag
```


<br>


### Publish to RubyGems.org
```Shell
$ gem push tchart-x.y.z.gem
```
