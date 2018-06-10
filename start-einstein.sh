#!/bin/bash
set -e

BASHRC_TEMPLATE_PATH="/etc/skel/.bashrc"
BASHRC_PATH="$HOME/.bashrc"

# If user doesn't already have a local .bashrc file
if [ ! -f "$BASHRC_PATH" ]; then
    # Copy the skeleton .bashrc file
    echo "Copying base .bashrc file to $BASHRC_PATH"
    cp $BASHRC_TEMPLATE_PATH $BASHRC_PATH

    # Set an alias for python2 to use that by default instead
    echo ""
    echo "# Comment this line and restart shell to use Python 3" >> $BASHRC_PATH
    echo "alias python='python2'" >> $BASHRC_PATH
fi

# Copy the tutorial notebook if it doesn't exist
if [ ! -f "$HOME/Cactus" ]; then
    tar -xf /tutorial/Cactus-UNAM.tar -C $HOME
fi

if [ ! -f "$HOME/EinsteinToolkit.ipynb" ]; then
    cp /tutorial/EinsteinToolkit.ipynb $HOME/
    wget --quiet http://141.142.41.4/EinsteinToolkit.ipynb -O $HOME/EinsteinToolkit.ipynb || true
fi

. /usr/local/bin/start.sh jupyter notebook $*
