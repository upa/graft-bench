#!/usr/bin/env python

import os
import re
import sys

def open_and_gather(filenames) :

    total = 0.0
    cnt = 0.0
    maxi = None
    mini = None

    for filename in filenames :
        with open(filename, "r") as f :
            for l in f :
                if "Summary" in l :
                    latency = float(l.split(' ')[4])
                    if not maxi or maxi < latency : maxi = latency
                    if not mini or mini > latency : mini = latency
                    total += latency
                    cnt += 1
    if cnt == 0 :
        print >> sys.stderr, "no summary matched %s" % filenames[0]

    return total / cnt, mini, maxi



if __name__ == '__main__' :

    rowname = sys.argv[1]
    prefix = sys.argv[2]

    filenames = []
    for filename in os.listdir("output"):

        if re.match(prefix, filename):
            filenames.append("output/" + filename)

    if len(filenames) == 0 :
        print >> sys.stderr, "no file matched for prefix '%s'" % prefix
        sys.exit(1)

    avg, mini, maxi = open_and_gather(filenames)
    print "%s\t%f\t%f\t%f" % (rowname, avg, mini, maxi)
