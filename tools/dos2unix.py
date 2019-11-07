#!/usr/bin/python

import sys,os

for fn in sys.argv[1:]:
	if not os.path.isfile(fn):
		print "%s is not a file!" % fn
		continue
	fnout = fn+".tmp"
	fin = open(fn, "r")
	fout = open(fnout,"w")
	changed = 0
	unchanged = 0
	for line in fin.readlines():
		if line[-2:] == '\r\n':
			line = line[:-2]+'\n'
			changed = changed + 1
		else:
			unchanged = unchanged + 1
		fout.write(line)
		
	fin.close()
	fout.close()
	os.system("mv %s %s" % (fnout, fn))
	print "mv %s %s, changed = %d, unchanged = %d" % \
			(fnout, fn, changed, unchanged)


