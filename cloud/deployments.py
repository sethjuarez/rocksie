import sys
import json

traffic = sys.argv[1]

with open(sys.argv[1], 'r') as f:
  traffic = json.load(f)

  if len(sys.argv) < 3 or "min" in sys.argv[2]:
    val = min(traffic.values())
  else:
    val = max(traffic.values())
  deployments = [k for k in traffic if traffic[k] == val]
  print(deployments[0])
