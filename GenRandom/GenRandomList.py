import random
count = 4;
data = list(range(int(1<<count)))
i = 0
while len(data) > 0:
    now = random.choice(data)
    data.remove(now)
#    print(hex((i + 257 + 1) % 257)[2:].zfill(3) + hex(now)[2:].zfill(2) + hex((i + 257 - 1) % 257)[2:].zfill(3))
    print(hex(now)[2:].zfill(int(count / 4)), end='')
    i += 1
for a in range(1<<count):
    print('0'.zfill(int(count / 4)), end='')
