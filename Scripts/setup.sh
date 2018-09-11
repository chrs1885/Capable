#!/bin/sh

# Run this script before contributing code.

#================================= Jazzy =================================
echo "Installing Jazzy for generating code documentation (https://github.com/realm/jazzy)"

gem install jazzy

#=============================== SwiftLint ===============================
echo "Installing SwiftLint to enforce the Capable coding style & conventions"

brew install swiftlint
