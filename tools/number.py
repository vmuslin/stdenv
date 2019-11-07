import sys
import string

f = open(sys.argv[1], 'r')
lines=f.readlines()
lineno=0
for line in lines:
	lineno=lineno+1
	line=string.replace(line, "\t", "        ")
	print "%5d %s" % (lineno, line),
f.close()
