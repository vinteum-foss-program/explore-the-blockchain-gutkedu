#!/bin/bash
source env.sh

# How many new outputs were created by block 123,456?

blockhash=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getblockhash 123456)

outputs=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getblock $blockhash 2 | jq '[.tx[].vout | length] | add')

echo $outputs
