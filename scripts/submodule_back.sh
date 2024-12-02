#!/bin/bash

set -e

SUBMODULE_PATH="Data"
SUBMODULE_REPO="git@github.com:LaTeam-Trancendence/Data.git"
BACKEND_API_PATH="Backend_API"

echo "Resetting submodule: $SUBMODULE_PATH"

# Step 0: Clean up any existing Data folder if it is not a valid Git repository
if [ -d "$SUBMODULE_PATH" ]; then
    if [ ! -d "$SUBMODULE_PATH/.git" ]; then
        echo "Cleaning up invalid submodule directory: $SUBMODULE_PATH"
        rm -rf "$SUBMODULE_PATH"
    else
        echo "$SUBMODULE_PATH is a valid Git repository."
    fi
fi

# Step 1: Remove submodule from Git index
if git ls-files --error-unmatch "$SUBMODULE_PATH" > /dev/null 2>&1; then
    echo "Removing submodule from Git index..."
    git rm --cached "$SUBMODULE_PATH"
fi

# Step 2: Remove .git/modules entry
if [ -d ".git/modules/$SUBMODULE_PATH" ]; then
    echo "Removing .git/modules/$SUBMODULE_PATH"
    rm -rf ".git/modules/$SUBMODULE_PATH"
fi

# Step 3: Clean references in .gitmodules
if [ -f .gitmodules ]; then
    echo "Cleaning .gitmodules..."
    sed -i "/submodule \"$SUBMODULE_PATH\"/,/^\[/{d}" .gitmodules
    git add .gitmodules
fi

# Step 4: Clean references in .git/config
if grep -q "path = $SUBMODULE_PATH" .git/config; then
    echo "Cleaning .git/config..."
    sed -i "/path = $SUBMODULE_PATH/d" .git/config
fi

# Step 5: Stage cleanup
echo "Staging cleanup..."
git add .git/config || true

# Step 6: Clean Backend_API while preserving specific files and directories
echo "Cleaning $BACKEND_API_PATH..."
find "$BACKEND_API_PATH" -mindepth 1 \
    ! -path "$BACKEND_API_PATH/scripts" \
    ! -path "$BACKEND_API_PATH/scripts/*" \
    ! -name 'Dockerfile' \
    -exec rm -rf {} +

# Step 7: Add submodule again
echo "Adding submodule: $SUBMODULE_PATH"
git submodule add "$SUBMODULE_REPO" "$SUBMODULE_PATH"
git submodule update --init --recursive "$SUBMODULE_PATH"

# Step 8: Handle the submodule contents
if [ -d "$SUBMODULE_PATH" ]; then
    echo "Entering $SUBMODULE_PATH directory..."
    cd "$SUBMODULE_PATH"
    echo "Copying contents of $SUBMODULE_PATH to $BACKEND_API_PATH..."
    cp -r * "../$BACKEND_API_PATH/"
    cd ..
    echo "Removing $SUBMODULE_PATH directory..."
    rm -rf "$SUBMODULE_PATH"
else
    echo "Error: Submodule directory $SUBMODULE_PATH not found!"
    exit 1
fi

echo "Submodule $SUBMODULE_PATH reset and contents copied successfully."
