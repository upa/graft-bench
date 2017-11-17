#!/usr/bin/env python



import sys

def extract(filename) :

    dat = {
        "avg" : None,
        "mid" : None,
        "min" : None,
        "max" : None,
        "98p" : None,
    }

    maximum = None
    minimum = None
    total = 0.0
    count = 0.0
    lats = [] # for midian

    with open(filename, 'r') as f :
        for line in f :
            lat = float(line.split(" ")[0])
            if not maximum or maximum < lat : maximum = lat
            if not minimum or minimum > lat : minimum = lat
            total += lat
            count += 1
            lats.append(lat)
            
    lats.sort()

    dat["avg"] = total / count
    dat["mid"] = lats[len(lats) / 2]
    dat["min"] = minimum
    dat["max"] = maximum
    dat["98p"] = lats[int(len(lats) * 0.9)]

    return dat


def rnd(msgsize) :
    
    if msgsize < 1000 :
        return str(msgsize)

    if msgsize < 1000000 :
        return "%dK" % (msgsize / 1000)

    return "%dM" % (msgsize / 1000000)



if __name__ == '__main__' :

    result = {} # msgsize : { avg : X, mid : X, min : X, max X }, ...

    # gather data
    for filename in sys.argv[1:] :
        
        msgsize = int(filename.split("-")[2].split("_")[1])

        dat = extract(filename)

        if not msgsize in result :
            result[msgsize] = []

        result[msgsize] = dat


    # calculate
    for msgsize, dat in sorted(result.items()) :

        print "%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f" % (rnd(msgsize),
                                                    dat["mid"], 
                                                    dat["98p"], dat["avg"],
                                                    dat["min"], dat["max"])
