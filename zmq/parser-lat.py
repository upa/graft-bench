#!/usr/bin/env python



import sys

def extract(filename) :

    dat = {
        "msgsize" : 0,
        "latency" : 0.0,
    }

    with open(filename, 'r') as f :
        for line in f :
            if "message" in line :
                dat["msgsize"] = int(line.split(" ")[2])

            elif "latency" in line :
                dat["latency"] = float(line.split(" ")[2])
    return dat


def rnd(msgsize) :
    
    if msgsize < 1000 :
        return str(msgsize)

    if msgsize < 1000000 :
        return "%dKB" % (msgsize / 1000)

    return "%dMB" % (msgsize / 1000000)



if __name__ == '__main__' :

    result = {} # msgsize : [ latency, latency ... ], ...

    # gather data
    for filename in sys.argv[1:] :
        
        dat = extract(filename)

        if not dat["msgsize"] in result :
            result[dat["msgsize"]] = []

        result[dat["msgsize"]].append(dat["latency"])


    # calculate
    for msgsize, latencies in sorted(result.items()) :

        minimum = None
        maximum = None
        total = 0.0
        count = 0.0

        for latency in latencies :

            if not minimum or latency < minimum : minimum = latency 
            if not maximum or latency > maximum : maximum = latency 
            
            total += latency
            count += 1
            avg = total / count
            
        print "%s\t%.2f\t%.2f\t%.2f" % (rnd(msgsize), avg, minimum, maximum )
