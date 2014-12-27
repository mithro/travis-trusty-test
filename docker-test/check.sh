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

# Check I can apt-get install
sudo apt-get -y --force-yes install vim

umask

# Check I can compile something
cat > test.c <<EOF
int main(void) {
  return 0;
}
EOF
ls -l test.c
gcc test.c -o test
./test
