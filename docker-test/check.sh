#!/bin/bash

set -x
set -e

# Check that I'm running under trusty
DISTRO=$(lsb_release -c -s)
if [ $DISTRO != "trusty" ]; then
  echo "Not running under trusty! (Running $DISTRO)"
  exit 1
fi

# Check that I'm still running under the travis user id
WHOAMI=$(whoami)
if [ $WHOAMI != "travis" ]; then
  echo "Username $WHOAMI not travis!"
  exit 1
fi

# Check that the PWD is the same location
OLD_PWD=$1
CUR_PWD=$PWD
if [ "$OLD_PWD" != "$CUR_PWD" ]; then
  echo "Current directory was '$CUR_PWD' not '$OLD_PWD'!"
  exit 1
fi

# Check I can still use sudo
sudo /bin/true

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
