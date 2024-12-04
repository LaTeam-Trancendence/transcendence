#!/bin/bash

set -e

SUBMODULE_PATH="Data"
SUBMODULE_REPO="git@github.com:LaTeam-Trancendence/Data.git"
BACKEND_API_PATH="Backend_API"

BLUE='\033[34m'
RED='\033[31m'
YELLOW='\033[33m'
RESET='\033[0m'


echo -e "${BLUE}Resetting submodule: $SUBMODULE_PATH${RESET}"

# Step 0: Clean up any existing Data folder if it is not a valid Git repository
if [ -d "$SUBMODULE_PATH" ]; then
    if [ ! -d "$SUBMODULE_PATH/.git" ]; then
        echo -e "${BLUE}Cleaning up invalid submodule directory: $SUBMODULE_PATH${RESET}"
        rm -rf "$SUBMODULE_PATH"
    else
        echo -e "${BLUE}$SUBMODULE_PATH is a valid Git repository.${RESET}"
    fi
fi

# Step 1: Remove submodule from Git index
if git ls-files --error-unmatch "$SUBMODULE_PATH" > /dev/null 2>&1; then
    echo -e "${BLUE}Removing submodule from Git index...${RESET}"
    git rm --cached "$SUBMODULE_PATH"
fi

# Step 2: Remove .git/modules entry
if [ -d ".git/modules/$SUBMODULE_PATH" ]; then
    echo -e "${BLUE}Removing .git/modules/$SUBMODULE_PATH${RESET}"
    rm -rf ".git/modules/$SUBMODULE_PATH"
fi

# Step 3: Clean references in .gitmodules
if [ -f .gitmodules ]; then
    echo -e "${BLUE}Cleaning .gitmodules...${RESET}"
    sed -i "/submodule \"$SUBMODULE_PATH\"/,/^\[/{d}" .gitmodules
    git add .gitmodules
fi

# Step 4: Clean references in .git/config
if grep -q "path = $SUBMODULE_PATH" .git/config; then
    echo -e "${BLUE}Cleaning .git/config...${RESET}"
    sed -i "/path = $SUBMODULE_PATH/d" .git/config
fi

# Step 5: Stage cleanup
echo -e "${BLUE}Staging cleanup...${RESET}"
git add .git/config || true

# Step 6: Clean Backend_API while preserving specific files and directories
echo -e "${BLUE}Cleaning $BACKEND_API_PATH...${RESET}"
find "$BACKEND_API_PATH" -mindepth 1 \
    ! -path "$BACKEND_API_PATH/scripts" \
    ! -path "$BACKEND_API_PATH/scripts/*" \
    ! -name 'Dockerfile' \
    -exec rm -rf {} +

# Step 7: Add submodule again
echo -e "${BLUE}Adding submodule: $SUBMODULE_PATH${RESET}"
git submodule add "$SUBMODULE_REPO" "$SUBMODULE_PATH"
git submodule update --init --recursive "$SUBMODULE_PATH"

# Step 8: Handle the submodule contents
if [ -d "$SUBMODULE_PATH" ]; then
    echo -e "${BLUE}Entering $SUBMODULE_PATH directory...${RESET}"
    cd "$SUBMODULE_PATH"
    echo -e "${BLUE}Copying contents of $SUBMODULE_PATH to $BACKEND_API_PATH...${RESET}"
    cp -r * "../$BACKEND_API_PATH/"
    cd ..
    echo -e "${BLUE}Removing $SUBMODULE_PATH directory...${RESET}"
    rm -rf "$SUBMODULE_PATH"
else
    echo -e "${RED}Error: Submodule directory $SUBMODULE_PATH not found!${RESET}"
    exit 1
fi

echo -e "${YELLOW}Submodule $SUBMODULE_PATH reset and contents copied successfully.${RESET}"
