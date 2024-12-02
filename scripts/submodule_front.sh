#!/bin/bash

set -e

SUBMODULE_PATH="Frontend"
SUBMODULE_NAME="front_transcendence"
SUBMODULE_REPO="git@github.com:LaTeam-Trancendence/front_transcendence.git"
FRONTEND_PATH="Frontend"

BLUE='\033[34m'
RED='\033[31m'
YELLOW='\033[33m'
RESET='\033[0m'

echo -e "${BLUE}Resetting submodule: $SUBMODULE_PATH/$SUBMODULE_NAME${RESET}"

# Step 0: Ensure the parent directory exists
if [ ! -d "$FRONTEND_PATH" ]; then
    echo -e "${RED}Error: Frontend directory does not exist! Please create it first.${RESET}"
    exit 1
fi

# Step 1: Clean up any existing submodule directory if it is not valid
if [ -d "$SUBMODULE_PATH/$SUBMODULE_NAME" ]; then
    if [ ! -d "$SUBMODULE_PATH/$SUBMODULE_NAME/.git" ]; then
        echo -e "${BLUE}Cleaning up invalid submodule directory: $SUBMODULE_PATH/$SUBMODULE_NAME${RESET}"
        rm -rf "$SUBMODULE_PATH/$SUBMODULE_NAME"
    else
        echo -e "${BLUE}$SUBMODULE_PATH/$SUBMODULE_NAME is a valid Git repository. Removing...${RESET}"
        rm -rf "$SUBMODULE_PATH/$SUBMODULE_NAME"
    fi
fi

# Step 2: Remove submodule from Git index
if git ls-files --error-unmatch "$SUBMODULE_PATH/$SUBMODULE_NAME" > /dev/null 2>&1; then
    echo -e "${BLUE}Removing submodule from Git index...${RESET}"
    git rm --cached "$SUBMODULE_PATH/$SUBMODULE_NAME"
fi

# Step 3: Remove .git/modules entry
if [ -d ".git/modules/$SUBMODULE_PATH/$SUBMODULE_NAME" ]; then
    echo -e "${BLUE}Removing .git/modules/$SUBMODULE_PATH/$SUBMODULE_NAME${RESET}"
    rm -rf ".git/modules/$SUBMODULE_PATH/$SUBMODULE_NAME"
fi

# Step 4: Clean references in .gitmodules
if [ -f .gitmodules ]; then
    echo -e "${BLUE}Cleaning .gitmodules...${RESET}"
	sed -i "/submodule \"$SUBMODULE_PATH\/$SUBMODULE_NAME\"/,/^\[/{d}" .gitmodules
    git add .gitmodules
fi

# Step 5: Clean references in .git/config
if grep -q "path = $SUBMODULE_PATH/$SUBMODULE_NAME" .git/config; then
    echo -e "${BLUE}Cleaning .git/config...${RESET}"
    sed -i "/path = $SUBMODULE_PATH/$SUBMODULE_NAME/d" .git/config
fi

# Step 6: Stage cleanup
echo -e "${BLUE}Staging cleanup...${RESET}"
git add .git/config || true

# Step 7: Remove the unwanted Frontend directory created in the wrong location
if [ -d "Frontend/Frontend" ]; then
    echo -e "${RED}Cleaning unwanted Frontend/Frontend directory...${RESET}"
    rm -rf "Frontend/Frontend"
fi

# Step 8: Add submodule again
echo -e "${BLUE}Adding submodule: $SUBMODULE_NAME${RESET}"
cd "$FRONTEND_PATH"
git submodule add "$SUBMODULE_REPO" "$SUBMODULE_NAME"
git submodule update --init --recursive "$SUBMODULE_NAME"
cd ..

echo -e "${YELLOW}Submodule $SUBMODULE_PATH/$SUBMODULE_NAME reset successfully.${RESET}"
