// This writes entropy to the /dev/trng pool using ioctl, so that
// entropy increases.

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/poll.h>
#include <unistd.h>
#include "infnoise.h"

static bool inmDebug;
static int inmDevTrngFD;

// Open /dev/trng
void inmWriteEntropyStart(struct opt_struct *opts) {
    inmDebug = opts->debug;
    inmDevTrngFD = open("/dev/trng", O_WRONLY);
    if (inmDevTrngFD < 0) {
        fprintf(stderr, "Unable to open /dev/trng\n");
        exit(1);
    }
}

// Write the bytes to /dev/trng.
void inmWriteEntropyToPool(uint8_t *bytes, uint32_t length) {
    ssize_t wsize;
    if ((wsize = write(inmDevTrngFD, &bytes, (size_t)length)) == -1) {
        fprintf(stderr, "Write to /dev/trng failed\n");
        exit(1);
    }
    // printf("Writing %u bytes to /dev/trng, %lu bytes written\n",
    //        length, wsize);
}
