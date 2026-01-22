#!/bin/bash
#

version=$1

if [ "$version" = "" ]; then
  echo "Usage: $0 x.y.z"
  echo ""
  echo "x.y.z is the version of Overleaf to pull and merge."
  exit 1
fi

sudo docker pull sharelatex/sharelatex:${version}
commit=$(sudo docker inspect sharelatex/sharelatex:${version} --format='{{index .Config.Labels "com.overleaf.ce.revision"}}')

echo
echo "> Preparing to pull commit: ${commit}"
echo "Note: You will likely have to fix conflicts after the merge."
echo -n "> Proceed? [yn] "
read ans

if [ "$ans" = "y" ]; then
  git fetch https://github.com/overleaf/overleaf main
  git merge ${commit}
else
  echo "Aborting."
  exit 1
fi
