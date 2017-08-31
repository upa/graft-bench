#!/bin/bash

# byte
for x in 64 256; do
	dd if=/dev/zero of=${x}byte.img bs=1 count=$x
done

# kilo byte
for x in 1 4 16 64 256; do
	dd if=/dev/zero of=${x}kbyte.img bs=1K count=$x
done

# mega byte
for x in 1 4 16 64; do
	dd if=/dev/zero of=${x}mbyte.img bs=1M count=$x
done
