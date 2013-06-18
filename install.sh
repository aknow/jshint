#!/bin/bash

cd ~

NODE_VERSION="v0.11.2"

NODE=$(which node || true)

# Node not exists.
if [ -z "${NODE}" ]; then
  # Install nvm to ~/.nvm
  echo "Install nvm ..."
  curl https://raw.github.com/creationix/nvm/master/install.sh -sL | sh

  # Use nvm immediately.
  echo "Install node ..."
  source $HOME/.nvm/nvm.sh
  nvm install $NODE_VERSION &> /dev/null
  nvm use $NODE_VERSION &> /dev/null

  # Enable nvm and node in shell profile.
  PROFILE="$HOME/.bashrc"
  if [ -f "$PROFILE" ] ; then
    echo "Write setting to $PROFILE ..."
    echo "source ~/.nvm/nvm.sh" >> $PROFILE
    echo "nvm use ${NODE_VERSION} &> /dev/null" >> $PROFILE
    echo 'alias node="$NVM_BIN/node"' >> $PROFILE
    echo 'alias npm="$NVM_BIN/npm"' >> $PROFILE
    echo "alias sudo='sudo '" >> $PROFILE
  else
    echo "=> Cannot find .bashrc"
    echo "   Append the following line to the correct file yourself"
    echo
    echo "\tsource ~/.nvm/nvm.sh"
    echo "\tnvm use ${NODE_VERSION} &> /dev/null"
    echo '\talias node="$NVM_BIN/node"'
    echo '\talias npm="$NVM_BIN/npm"'
    echo "\talias sudo='sudo '"
    echo
  fi
fi

# Install our own JSHint.
echo "Uninstall jshint (if existed) ..."
npm uninstall -g jshint &> /dev/null

echo "Install jshint ..."
npm install -g git://github.com/aknow/jshint-gecko.git

# Create config and wrapper command.
echo "Create ~/.jshintrc ..."
curl https://raw.github.com/aknow/jshint-gecko/master/gecko/ril.jshintrc -sLo ~/.jshintrc &> /dev/null
echo "Create wrapper command /usr/bin/jshint-gecko (sudo) ..."
sudo curl https://raw.github.com/aknow/jshint-gecko/master/gecko/jshint-gecko -sLo /usr/bin/jshint-gecko &> /dev/null
sudo chmod +x /usr/bin/jshint-gecko

echo "=> Now you could use 'jshint' and 'jshint-gecko' commands"

