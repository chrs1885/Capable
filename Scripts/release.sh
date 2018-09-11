#!/bin/bash

# Run this script from the root directory just before releasing a new Capable version.

#============================= Documentation =============================
echo "Updating framework documentation"

jazzy

#========================== Example dependencies =========================
echo "Updating Capable dependency in example project"

cd Example
pod install
cd ..