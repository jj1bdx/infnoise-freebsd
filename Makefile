GIT_VERSION	!= git --no-pager describe --tags --always
GIT_COMMIT	!= git rev-parse --verify HEAD
GIT_DATE	!= git --no-pager show --date=iso-strict --format="%ad" --name-only | head -1 | cut -f 1 -d " "

DESTDIR=	/usr/local/bin
PROG=	infnoise-freebsd
SRCS=	infnoise.c infnoise.h healthcheck.c writeentropy.c daemon.c KeccakF-1600-reference.c endianness.h
MAN=

CFLAGS+= -Wall -Wextra -Werror -std=c99 \
	-O3 -finline-functions \
	-I/usr/local/include/libftdi1 \
	-DGIT_VERSION=\"$(GIT_VERSION)\"\
	-DGIT_COMMIT=\"$(GIT_COMMIT)\"\
	-DGIT_DATE=\"$(GIT_DATE)\"

LDFLAGS+= -L/usr/local/lib -lftdi -lusb -lm

.include <bsd.prog.mk>
