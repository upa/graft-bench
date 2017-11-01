#!/usr/bin/env python

import sys
import os
import commands

for filename in os.listdir(".") :
    if ("graph-" in filename and ".pdf" in filename and
        not "cropped_" in filename) :
        name, suffix = filename.split(".")
        i = filename
        o = "cropped_%s.pdf" % name

        if os.path.exists(o) :
            if os.stat(i).st_mtime < os.stat(o).st_mtime :
                continue

        cmd = "pdfcrop %s %s" % (i, o)
        print cmd
        commands.getoutput(cmd)
