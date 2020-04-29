#!/bin/bash
# Running this script will install all of the extensions listed
# in the extensions.txt file in this folder.
cat extensions.txt | xargs -n1 code --install-extension