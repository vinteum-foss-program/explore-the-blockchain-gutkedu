#!/bin/bash
source env.sh

# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

descriptorInfo=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getdescriptorinfo "tr(xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2/*)" | jq -r '.descriptor')

answer=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" deriveaddresses "$descriptorInfo" "[100,100]" | jq -r '.[0]')

echo $answer
