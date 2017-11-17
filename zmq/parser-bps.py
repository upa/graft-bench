#!/usr/bin/env python



import sys

def extract(filename) :

    dat = {
        "msgsize" : 0,
        "mps" : 0.0,
        "bps" : 0.0
    }

    with open(filename, 'r') as f :
        for line in f :
            if "message size" in line :
                dat["msgsize"] = int(line.split(" ")[2])

            elif "msg/s" in line :
                dat["mps"] = float(line.split(" ")[2])

            elif "Mb/s" in line :
                dat["bps"] = float(line.split(" ")[2]) * 1000000

    return dat


def rnd(msgsize) :
    
    if msgsize < 1000 :
        return str(msgsize)

    if msgsize < 1000000 :
        return "%dKB" % (msgsize / 1000)

    return "%dMB" % (msgsize / 1000000)



if __name__ == '__main__' :

    result = {} # msgsize : [ bps, bps ... ], ...

    # gather data
    for filename in sys.argv[1:] :
        
        dat = extract(filename)

        if not dat["msgsize"] in result :
            result[dat["msgsize"]] = []

        result[dat["msgsize"]].append(dat["bps"])



    # calculate
    for msgsize, bpses in sorted(result.items()) :

        minimum = None
        maximum = None
        total = 0.0
        count = 0.0

        for bps in bpses :

            if not minimum or bps < minimum : minimum = bps 
            if not maximum or bps > maximum : maximum = bps 
            
            total += bps
            count += 1
            avg = total / count
            
        print "%s\t%.2f\t%.2f\t%.2f" % (rnd(msgsize), avg, minimum, maximum )
