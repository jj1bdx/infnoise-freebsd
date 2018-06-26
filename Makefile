GIT_VERSION := $(shell git --no-pager describe --tags --always)
GIT_COMMIT  := $(shell git rev-parse --verify HEAD)
GIT_DATE    := $(firstword $(shell git --no-pager show --date=iso-strict --format="%ad" --name-only))

PREFIX = $(DESTDIR)/usr/local

INCLUDEFTDI = /usr/local/include/libftdi1
#INCLUDEFTDI = /usr/include/libftdi1

CFLAGS = -Wall -Wextra -Werror -std=c99 -O3 -I Keccak -I $(INCLUDEFTDI) \
 -DGIT_VERSION=\"$(GIT_VERSION)\"\
 -DGIT_COMMIT=\"$(GIT_COMMIT)\"\
 -DGIT_DATE=\"$(GIT_DATE)\"\
 -DBUILD_DATE=\"$(BUILD_DATE)\"

FOUND = $(shell /sbin/ldconfig -p | grep --silent libftdi.so && echo found)
ifeq ($(FOUND), found)
        FTDI=   -lftdi
else
        FTDI=   -lftdi1
endif

# Still doesn't work with macOS
#FTDI= /usr/local/lib/libftdi1.dylib /usr/local/lib/libusb.dylib
# FreeBSD works ok with this (use Port libftdi1 and stock libusb)
FTDI= -L/usr/local/lib -lftdi -lusb

#LIBRT = -lrt
# FreeBSD and macOS doesn't need librt
LIBRT = 

all: infnoise

infnoise: infnoise.c infnoise.h healthcheck.c writeentropy.c daemon.c Keccak/KeccakF-1600-reference.c Keccak/brg_endian.h
	$(CC) $(CFLAGS) -o infnoise infnoise.c healthcheck.c writeentropy.c daemon.c Keccak/KeccakF-1600-reference.c $(FTDI) -lm $(LIBRT)

clean:
	$(RM) infnoise

install:
	install -d $(PREFIX)/sbin
	install -m 0755 infnoise $(PREFIX)/sbin/
	install -d $(PREFIX)/lib/udev/rules.d/
	install -m 0644 init_scripts/75-infnoise.rules $(PREFIX)/lib/udev/rules.d/
	install -d $(PREFIX)/lib/systemd/system
	install -m 0644 init_scripts/infnoise.service $(PREFIX)/lib/systemd/system

postinstall:
	systemctl restart systemd-udevd
	systemctl enable infnoise
