# Infinity Noise Driver for FreeBSD

See <https://github.com/13-37-org/infnoise> for the original contents.

## Changes from the original repository

* Remove unnecessary files for FreeBSD
* Reconfigured for FreeBSD Make
* Use `/dev/trng` instead of `/dev/random` for the entropy feeding (see <https://github.com/jj1bdx/freebsd-dev-trng/> for the device installation)
* Tested on FreeBSD amd64 11.2-STABLE r335572

## LICENSE

[Unlicense](http://unlicense.org/), equivalent to the public domain
