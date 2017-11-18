#!/usr/bin/env python



import sys

def extract(filename) :

    mps = {
        "avg" : None,
        "mid" : None,
        "min" : None,
        "max" : None,
    }

    bps = {
        "avg" : None,
        "mid" : None,
        "min" : None,
        "max" : None,
    }


    # 1. Extract Message per Second
    maximum = None
    minimum = None
    total = 0.0
    count = 0.0
    n = 0
    msgs = [] # for midian
    with open(filename, 'r') as f :
        for line in f :
            if n < 5:
                n += 1
                continue
            if not "msg/s" in line : continue
            msg = float(line.split(" ")[1])
            if not maximum or maximum < msg : maximum = msg
            if not minimum or minimum > msg : minimum = msg
            total += msg
            count += 1
            msgs.append(msg)

    for n in range(5) : msgs.pop()

    msgs.sort()
    mps["avg"] = total / count
    mps["mid"] = msgs[len(msgs) / 2]
    mps["min"] = minimum
    mps["max"] = maximum

    # 2. Extract Bit per Second
    maximum = None
    minimum = None
    total = 0.0
    count = 0.0
    n = 0
    bits = [] # for midian
    with open(filename, 'r') as f :
        for line in f :
            if n < 5:
                n += 1
                continue
            if not "bit/s" in line : continue
            bit = float(line.split(" ")[3])
            if not maximum or maximum < bit : maximum = bit
            if not minimum or minimum > bit : minimum = bit
            total += bit
            count += 1
            bits.append(bit)
    for n in range(5) : bits.pop()
    bits.sort()
    bps["avg"] = total / count
    bps["mid"] = bits[len(bits) / 2]
    bps["min"] = minimum
    bps["max"] = maximum

    return mps, bps


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
        
        for param in filename.split("-") :
            if "msgsize" in param :
                msgsize = int(param.split("_")[1].split(".")[0])
                break

        mps, bps = extract(filename)

        if not msgsize in result :
            result[msgsize] = []

        result[msgsize] = [mps, bps]


    # calculate
    print "#Size\tAvgBps\tMidBps\tAvgMps\tMidMps"
    for msgsize, [ mps, bps ] in sorted(result.items()) :
        print "%s\t%.2f\t%.2f\t%.2f\t%.2f" % (rnd(msgsize),
                                              bps["avg"], bps["mid"],
                                              mps["avg"], mps["mid"])
