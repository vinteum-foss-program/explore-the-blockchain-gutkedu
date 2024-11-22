# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

tx_id="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

# retrieve the raw transaction: fetches the raw transaction details for the specified `tx_id`
raw_tx=$(bitcoin-cli -rpcconnect="84.247.182.145" -rpcuser="user_071" -rpcpassword="PGNf2H0Psfdy" getrawtransaction "$tx_id" true)

# Extract the Redeem Script:
# For P2WSH transactions, the `txinwitness` field contains the redeem script as its third element;
# The redeem script includes the public keys involved in the multisig setup;
redeem_script=$(echo "$raw_tx" | jq -r '.vin[0].txinwitness[2]')

# Extract the Public Key:
# extract the first public key from the redeem script using `grep` and a regex pattern;
# The regex pattern `02[0-9a-fA-F]{64}` matches the compressed public key format;
public_key=$(echo "$redeem_script" | grep -oE '02[0-9a-fA-F]{64}' | head -n1)

echo $public_key
