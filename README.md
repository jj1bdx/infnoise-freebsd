# Infinity Noise Driver for FreeBSD

See <https://github.com/13-37-org/infnoise> for the original contents.

## Changes from the original repository

* Remove unnecessary files for FreeBSD
* Reconfigured for FreeBSD Make
* Use `/dev/trng` instead of `/dev/random` for the entropy feeding (see <https://github.com/jj1bdx/freebsd-dev-trng/> for the device installation)
* Use getopt(3) or getopt\_long(3)
* Add `-w` or `--wait-time` option
* Tested on FreeBSD amd64 12.0-PRERELEASE r340660
* (Previously tested on FreeBSD amd64 11.2-STABLE r335572)
* Adding a wait time up to 5ms per USB polling of 512 bytes: ~98kbytes/sec (still sufficiently fast for providing OS entropy)
* Lowering the FTDI FT240X baud rate only resulted in consuming more CPU time, ineffective

## LICENSE

[Unlicense](http://unlicense.org/), equivalent to the public domain
