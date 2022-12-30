import sys

if len(sys.argv) < 4:
    print("usage: " + sys.argv[0] + " <filename> <start> <end>")
    exit(1)



with open(sys.argv[1], 'r') as f:
    data = f.readlines()

for a in data:
    print("".join(a[int(sys.argv[2]):int(sys.argv[3])]))


