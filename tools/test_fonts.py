import string
import os
import time

cmd="xterm -name '%s - %d of %d' -fn %s"

f = open('/tmp/fonts')   # output of xlsfonts command
lines = f.readlines()

tot = len(lines)
n = 1

for l in lines:
    font = string.split(l)[0]
    if font[0] == '-':
        continue
    os.system(cmd % (font, n, tot, font))
    n = n + 1
