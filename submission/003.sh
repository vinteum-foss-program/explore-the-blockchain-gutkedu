# How many new outputs were created by block 123,456?

blockhash=$(bitcoin-cli getblockhash 123456)

outputs=$(bitcoin-cli getblock $blockhash 2 | jq '[.tx[].vout | length] | add')

echo $outputs
