import string
import os
import time

cmd="xterm -name '%s - %d of %d' -bg %s"

f = open('/usr/lib/X11/rgb.txt')
lines = f.readlines()

tot = len(lines)
n = 1

for l in lines:
    color = string.split(l)[3]
    os.system(cmd % (color, n, tot, color))
    n = n + 1
