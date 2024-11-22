#!/bin/bash
source env.sh

# How many new outputs were created by block 123,456?

blockhash=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblockhash 123456)

outputs=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblock $blockhash 2 | jq '[.tx[].vout | length] | add')

echo $outputs
