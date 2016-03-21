#include <stddef.h>
#include <stdio.h>
#include "aracap.h"

void MCL_hex2bin(char *src, char *dst, int src_len)
{
  int i;
  char v;
  for (i = 0; i < src_len/2; i++) {
    char c = src[2*i];
    if (c >= '0' && c <= '9') {
        v = c - '0';
    } else if (c >= 'A' && c <= 'F') {
        v = c - 'A' + 10;
    } else if (c >= 'a' && c <= 'f') {
        v = c - 'a' + 10;
    } else {
        v = 0;
    }
    v <<= 4;
    c = src[2*i + 1];
    if (c >= '0' && c <= '9') {
        v += c - '0';
    } else if (c >= 'A' && c <= 'F') {
        v += c - 'A' + 10;
    } else if (c >= 'a' && c <= 'f') {
        v += c - 'a' + 10;
    } else {
        v = 0;
    }
    dst[i] = v;
  }
}

int main(int argc, char **argv) {
    authenticate_component(0);
    return 0;
}
