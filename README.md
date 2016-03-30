DTRACE
======

Sandbox for working on DTrace stacktrace helper for Ruby. Runs SmartOS in
Vagrant to give us an environment where userland stacktraces are not disabled
in DTrace (as they are in OS X).

Actual code for the stacktrace helper is at http://github.com/sax/dtrace-stacktraces

### local setup

```
./setup
vagrant up
vagrant ssh
cd /vagrant/dtrace-stacktrace-sandbox
./setup_zone
```

This is likely to be **very** slow, as many packages are downloaded from the other
side of country with severe bandwidth limiting. Once this is finished, you can
make a local dataset out of the running zone.

```
vagrant dataset create ruby-dtrace-sandbox ruby-dtrace-sandbox
vagrant zones config dataset.842e6fa6-6e9b-11e5-8402-1b490459e334 ruby-dtrace-sandbox
```

This will make it so that the next time you `vagrant up` with a SmartOS zone
configured to use image `842e6fa6-6e9b-11e5-8402-1b490459e334` it will instead
use your local bits.


### development

To test some bit of code in the dtrace-stacktraces gem, run the following:

```
vagrant ssh
cd /vagrant/dtrace-stacktrace-sandbox
./test
```

Local changes are not immediately reflected in the VM. To sync changes, run the
following in your host machine. Note that this will blow away any changes in
the zone.

```
./sync
```

D scripts to run:

```
dtrace -n 'ruby*:sandbox:: { printf("%s", copyinstr(arg0)) }'
dtrace -n 'ruby*:sandbox:: { ustack() }'
dtrace -n 'pid$target:libc:: { ustack() }' -p `pgrep ruby`
```

### cleanup

When you are done developing, you will want to:

```
vagrant destroy -f
```

