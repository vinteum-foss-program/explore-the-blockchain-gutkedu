#!/bin/bash
source env.sh

# (true / false) Verify the signature by this address over this message:
#   address: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   message: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   signature: `HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM=`

answer=$(bitcoin-cli -rpcconnect="$RPC_CONNECT" -rpcuser="$RPC_USER" -rpcpassword="$RPC_PASSWORD" verifymessage "1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa" "HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM=" "1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa")

echo $answer
