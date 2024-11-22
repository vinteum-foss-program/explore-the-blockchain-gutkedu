# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

tx=$(bitcoin-cli getrawtransaction "$txid" true)

inputs=$(echo "$tx" | jq -c '.vin')

# Initialize an array for public keys without extra quotes
pubkeys=()

# Loop through each input to extract public keys from txinwitness
for input in $(echo "$inputs" | jq -c '.[]'); do
  # Extract the public key from txinwitness
  pubkey=$(echo "$input" | jq -r '.txinwitness[1]')
  
  # Add the public key to the array if it's not empty
  if [ -n "$pubkey" ]; then
    pubkeys+=("$pubkey")
  fi
done

# check if array has four public keys
if [ ${#pubkeys[@]} -ne 4 ]; then
  echo "Error: Expected 4 public keys, but found ${#pubkeys[@]}."
  exit 1
fi

# Create a JSON array of public keys
pubkeys_json=$(printf '%s\n' "${pubkeys[@]}" | jq -R . | jq -s .)

# number of required signatures
required=1

# Create the P2SH multisig address
multisig=$(bitcoin-cli createmultisig "$required" "$pubkeys_json")

# Extract the address
address=$(echo "$multisig" | jq -r '.address')

echo $address