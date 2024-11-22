#!/bin/bash
source env.sh

# What is the hash of block 654,321?

answer=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getblockhash 654321) 

echo $answer