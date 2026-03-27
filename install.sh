#!/usr/bin/env bash
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_FILE="${SCRIPT_DIR}/skills.txt"

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  Binance Skills Pack - One-Click Installer  ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# Check npx
if ! command -v npx &>/dev/null; then
    echo -e "${RED}[ERROR] Node.js/npm not found. Install first:${NC}"
    echo "  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
    echo "  sudo apt-get install -y nodejs"
    exit 1
fi

# Count skills
TOTAL=$(grep -cvE '^\s*$|^\s*#' "$SKILLS_FILE" 2>/dev/null || echo 0)
echo -e "Found ${YELLOW}${TOTAL}${NC} skills to install."
echo ""

COUNT=0
SUCCESS=0
FAILED=0
FAILED_LIST=""

while IFS= read -r skill || [[ -n "$skill" ]]; do
    skill=$(echo "$skill" | xargs)
    [[ -z "$skill" || "$skill" == \#* ]] && continue

    COUNT=$((COUNT + 1))
    echo -e "${CYAN}[${COUNT}/${TOTAL}]${NC} Installing: ${YELLOW}${skill}${NC}"

    if npx playbooks add skill openclaw/skills --skill "$skill" 2>/dev/null; then
        echo -e "  ${GREEN}[OK]${NC} ${skill} installed successfully."
        SUCCESS=$((SUCCESS + 1))
    else
        echo -e "  ${RED}[FAIL]${NC} ${skill} installation failed."
        FAILED=$((FAILED + 1))
        if [[ -n "$FAILED_LIST" ]]; then
            FAILED_LIST="${FAILED_LIST}, ${skill}"
        else
            FAILED_LIST="${skill}"
        fi
    fi
    echo ""
done < "$SKILLS_FILE"

echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  Installation Complete${NC}"
echo -e "${CYAN}============================================${NC}"
echo -e "  Total:   ${TOTAL}"
echo -e "  Success: ${GREEN}${SUCCESS}${NC}"
echo -e "  Failed:  ${RED}${FAILED}${NC}"
if [[ $FAILED -gt 0 ]]; then
    echo -e "  Failed skills: ${RED}${FAILED_LIST}${NC}"
fi
echo -e "${CYAN}============================================${NC}"
echo ""

echo -e "${YELLOW}Next steps:${NC}"
echo "  export BINANCE_API_KEY=your-api-key"
echo "  export BINANCE_SECRET=your-api-secret"
echo "  export BINANCE_TESTNET=1    # Test first!"
echo ""
