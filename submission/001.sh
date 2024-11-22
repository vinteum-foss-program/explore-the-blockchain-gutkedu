#!/bin/bash
source env.sh

# What is the hash of block 654,321?

answer=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblockhash 654321) 

echo $answer