#!/bin/bash
source env.sh

# Which tx in block 257,343 spends the coinbase output of block 256,128?

# Get the block hash of block 256128
block_hash=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblockhash 256128)

# Coinbase transaction ID of block 256128 is the first transaction in the block
coinbase_tx_id=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblock "$block_hash" 1 | jq -r '.tx[0]')

# Get the block hash of block 257343
target_block_hash=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblockhash 257343)

# Get all transaction ids in block 257343
transaction_ids=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getblock "$target_block_hash" 1 | jq -r '.tx[]')

# Iterate through each transaction to find the one that spends the coinbase output
for tx_id in $transaction_ids; do
  # Get the raw transaction details
  raw_tx=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" getrawtransaction "$tx_id" true)

  # Check each input of the transaction
  vin_count=$(echo "$raw_tx" | jq '.vin | length')
  for ((i=0; i<vin_count; i++)); do
    input_txid=$(echo "$raw_tx" | jq -r ".vin[$i].txid")
    if [ "$input_txid" == "$coinbase_tx_id" ]; then
    # Output the transaction ID that spends the coinbase output
      echo $tx_id
      exit 0
    fi
  done
done

echo "No transaction in block 257343 spends the coinbase output of block 256128."