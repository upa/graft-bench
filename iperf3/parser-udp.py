#!/usr/bin/env python

import os
import re
import sys
import json

def open_and_gather(filenames) :

    total = 0.0
    cnt = 0.0
    maxi = None
    mini = None

    for filename in filenames :

        with open(filename, 'r') as f :
            jsonstring = ""

            for l in f :
                if not "libgrwrap" in l :
                    jsonstring += l

            try :
                res = json.loads(jsonstring)
            except ValueError as e:
                print "%s: %s" % (filename, e.message)
                print jsonstring
                sys.exit(1)
                
        bps = res["end"]["sum"]["bits_per_second"]
        if not maxi or maxi < bps : maxi = bps
        if not mini or mini > bps : mini = bps

        total += bps
        cnt += 1
        
    return total / cnt, mini, maxi


if __name__ == '__main__' :

    rowname = sys.argv[1]
    prefix = sys.argv[2]

    filenames = []
    for filename in os.listdir("output") :
        if re.match(prefix, filename) :
            filenames.append("output/" + filename)

    # Gbps
    n = 1000 * 1000 * 1000

    avg, mini, maxi = open_and_gather(filenames)
    print "%s\t%f\t%f\t%f" % (rowname, avg / n, mini / n, maxi / n)
    
