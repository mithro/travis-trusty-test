#!/bin/bash

set -x
set -e

cd /tmp

# Check that I'm running under trusty
if [ $(lsb_release -c -s) != "trusty" ]; then
  echo "Not running under trusty!"
  exit 1
fi

# Check that I'm still running under the travis user id
if [ $(whoami) != "travis" ]; then
  echo "Username $(whoami) not travis!"
  exit 1
fi

# Check I can still use sudo
sudo /bin/true

which apt-key || true
sudo apt-key list || true
sudo apt-key update || true
sudo apt-get -y --force-yes install add-apt-key ubuntu-keyring ubuntu-extras-keyring
which apt-key || true
sudo apt-key list || true
sudo apt-key update || true

# Check I can apt-get install
sudo apt-get update
sudo apt-get -y install vim

# Check I can compile something
cat > test.c <<EOF
int main(void) {
  return 0;
}
EOF
ls -l test.c
gcc test.c -o test
./test
