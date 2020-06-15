#!/bin/bash -e

cd $(dirname $0)/..
LOCAL_PATH=$PWD

for patch in $(cd patch/; find . -name \*.patch); do
  echo == Applying $patch
  (
    cd $(dirname $patch)
    if patch --dry-run --forward --silent -p1 < $LOCAL_PATH/patch/$patch; then
      (
        set -x
        patch --forward -p1 < $LOCAL_PATH/patch/$patch
      )
    fi
  )
done

if [[ ! -r public_html/terminal.css ]]; then
  wget -O public_html/terminal.css \
    https://raw.githubusercontent.com/buildkite/terminal/v3.1.0/assets/terminal.css
fi

exit 0
