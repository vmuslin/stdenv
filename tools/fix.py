import sys
import string

file=sys.argv[1]
f=open(file)
b=f.read()

c=string.split(b,"\\N")
for i in c:
	print string.strip(string.replace(string.replace(i, ' ', ''), '"', ''))
