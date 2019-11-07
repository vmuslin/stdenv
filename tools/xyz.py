import sys

prefix=sys.argv[1]
for f in sys.argv[2:]:
	print "%s/%s " % (prefix, f),
