#!/bin/bash

# clear the screen
clear

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m' # No color

# Check for query input
if [[ -z $1 ]]; then
    echo -e "${RED}Error:${NC} No query provided. Usage: ./script.sh <query>"
    exit 1
fi

# Variables
query=$1
API_URL="https://api.proxynova.com/comb?query=$query"

# Fetch data and validate response
response=$(curl -sL "$API_URL")
if [[ -z $response ]]; then
    echo -e "${RED}Error:${NC} Failed to fetch data from the API."
    exit 1
fi

# Header
echo
echo "      :::::::::  :::       ::: :::::::::  :::::::::: :::    ::: :::::::::::              "
echo "     :+:    :+: :+:       :+: :+:    :+: :+:        :+:    :+:     :+:          Created  "
echo "    +:+    +:+ +:+       +:+ +:+    +:+ +:+         +:+  +:+      +:+        By Trabbit  "
echo "   +#++:++#+  +#+  +:+  +#+ +#+    +:+ +#++:++#     +#++:+       +#+         ----------  "
echo "  +#+        +#+ +#+#+ +#+ +#+    +#+ +#+         +#+  +#+      +#+                      "
echo " #+#         #+#+# #+#+#  #+#    #+# #+#        #+#    #+#     #+#                       "
echo "###          ###   ###   #########  ########## ###    ###     ###                        "
echo
echo -e "${CYAN}======================================================"
echo -e "      Extracted Usernames & Passwords"
echo -e "======================================================${NC}"

# Process the response
echo "$response" | jq -r '.lines[]' | grep -E "[:;]" | awk -F '[:;]' -v YELLOW="$YELLOW" -v GREEN="$GREEN" -v CYAN="$CYAN" -v NC="$NC" \
'BEGIN { printf "%-30s %-30s\n", CYAN"   Username", "       Password"NC; print "------------------------------------------------------------" } 
{ printf YELLOW"%-30s"NC GREEN"%-30s\n"NC, $1, $2 }'

# Footer
echo -e "${CYAN}======================================================"
echo -e "                Extraction Complete"
echo -e "======================================================${NC}"
