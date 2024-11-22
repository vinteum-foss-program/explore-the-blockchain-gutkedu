# Only one single output remains unspent from block 123,321. What address was it sent to?

block_height=123321

block_hash=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getblockhash $block_height)

# Get the block details
block=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getblock $block_hash 2)

# Iterate through each transaction in the block
for tx_id in $(echo "$block" | jq -r '.tx[].txid'); do
  # Raw transaction details
  raw_tx=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getrawtransaction $tx_id true)
  
  # Iterate through each output in the transaction
  for vout in $(echo "$raw_tx" | jq -r '.vout[] | @base64'); do
    _jq() {
      echo ${vout} | base64 --decode | jq -r ${1}
    }
    
    # Check if the output is unspent
    spent=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" gettxout $tx_id $(_jq '.n'))
    if [ -n "$spent" ]; then
      # Output the address
      address=$(_jq '.scriptPubKey.address')
      echo $address
      exit 0
    fi
  done
done

echo "No unspent outputs found in block $block_height."