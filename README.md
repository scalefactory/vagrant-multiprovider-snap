Vagrant Multi-Provider Snap
==========================

Description
-----------

This Vagrant plugin provides a consistent interface to taking snapshots of
running Vagrant boxes.  It currently supports the following providers:

 * VirtualBox
 * VMWare Fusion (via the commercial VMWare plugin)
 * VMWare Workstation (via the commercial VMWare plugin)
 * Hyper-V


Installation
------------

The easiest way to install this plugin is via the published gem.

```
vagrant plugin install vagrant-multiprovider-snap
```


Usage
-----

Take a new snapshot:

    vagrant snap take [vm]

Roll back to the last snapshot:

    vagrant snap rollback [vm]

List snapshots:

    vagrant snap list [vm]

Take a custom-named snapshot:

    vagrant snap take [vm] --name=snap01

Roll back to a named snapshot:

    vagrant snap rollback [vm] --name=snap01

Delete a snapshot

    vagrant snap delete [vm] --name=snap01

Limitations
-----------

It's currently not possible to do any of the following:

 * Disable snapshotting

My own requirements don't include this feature, but I could be tempted to
add them if anyone would find them useful.


Hacking
-------

Working on this module is a little tricky because of the obfuscation used by
the commercial VMWare module.  The following approach should get you up and
running - although it's a bundler environment, you'll also need a packaged
Vagrant install in order to get access to the rgloader libraries.

```
git clone git@github.com:scalefactory/vagrant-multiprovider-snap.git
cd vagrant-multiprovider-snap
bundle install
```

You should now find that ```bundle exec vagrant status``` returns correctly,
and you can hack on the code from there.

Once you've made changes that you're happy with, I'd recommend using
```rake build``` to create a gem, then installing that into your packaged
Vagrant install since some things which work in the bundler environment might
not work as expected in the packaged copy due to differences in how the plugins
are handled.

License
-------
vagrant-multiprovider-snap is licensed under the MIT license.


Thanks
------

vagrant-multiprovider-snap was written, and is maintained by Jon Topper of [The Scale Factory](http://www.scalefactory.com/)

Many thanks to the following people for contributing to vagrant-multiprovider-snap:

 - Reid Vandewiele
 - James Sweeny
 - Steven De Coeyer
 - Andrew Stangl
 - Stefan Scherer

