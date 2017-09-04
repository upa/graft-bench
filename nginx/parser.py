#!/usr/bin/env python

import re
import sys


def open_and_gather(filename, col) :

    total = 0.0
    cnt = 0.0
    maxi = None
    mini = None

    with open(filename, 'r') as f :
        for line in f :
            
            if "Date" in line : continue

            line = re.sub(r'\t|\s', '', line)

            s = line.split(',')
            
            val = float(s[col])
            total += val
            if not maxi or maxi < val :
                maxi = val
            if not mini or mini > val :
                mini = val

            cnt += 1.0

    return total / cnt, mini, maxi


if __name__ == '__main__' :

    col = int(sys.argv[1])
    prefix = sys.argv[2]
    
    for size in [ "64", "256", "1k", "4k", "16k", "64k", "256k",
                  "1m", "4m", "16m", "64m" ] :

        filename = "%s%s.txt" % (prefix, size)

        avg, mini, maxi = open_and_gather(filename, col)
        print "%s\t%f\t%f\t%f" % (size.upper(), avg, mini, maxi)
