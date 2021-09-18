import sys

args = sys.argv[2:]
template = sys.argv[1]

kwargs = {}

for i in range(int(len(args) / 2)):
    kwargs[args[2*i].replace('--', '')] = args[2*i+1]

with open(template, 'r') as f:
    t = f.read().format(**kwargs)
    print(t)
