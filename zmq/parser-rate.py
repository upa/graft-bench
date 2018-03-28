#!/usr/bin/env python

import sys


def get_value_list(filename, c) :
    
    xtics = []
    value = []

    with open(filename, 'r') as f :
        for line in f :

            if '#' in line : continue

            s = line.split('\t')
            xtics.append(s[0])
            value.append(float(s[c]))
    
    return xtics, value

def value_rate(v1, v2) :
    
    r = []

    for n in range(len(v1)) :
        #f = lambda x, y: (x - y) / x
        f = lambda x, y: y / x - 1
        r.append(f(v1[n], v2[n]))

    return r


column = int(sys.argv[1])
x, v1 = get_value_list(sys.argv[2], column)
x, v2 = get_value_list(sys.argv[3], column)


r = value_rate(v1, v2)
for n in range(len(x)) :
    print "%s\t%.2f" % (x[n], r[n] * 100)



