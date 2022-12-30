import sys

if len(sys.argv) < 2:
    print("usage: " + sys.argv[0] + " <filename>")
    exit(1)



with open(sys.argv[1], 'r') as f:
    data = f.readlines()

for a in data:
    print(a.strip()[::-1])


