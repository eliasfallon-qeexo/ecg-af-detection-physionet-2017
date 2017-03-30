#!/bin/bash
#
# file: prepare-entry.sh
#
# This script shows how to run the example code (setup.sh and next.sh)
# over the validation set, in order to produce the list of expected
# answers (answers.txt) which must be submitted as part of your entry.
# This script itself does not need to be included in your entry.

set -e
set -o pipefail

FAILED=YES

function cleanup {
    if [ "$FAILED" = "YES" ]; then
        >&2 echo "An error occurred while preparing entry"
    fi
    echo "Cleaning up"
    rm -R outputs/entry || true
}
trap cleanup EXIT

echo "==== running setup script ===="

#./setup.sh

echo "==== running entry script on validation set ===="

rm -R outputs/entry >/dev/null 2>&1 || true
rm -r outputs/entry.zip >/dev/null 2>&1 || true
#rm -f answers.txt

#python3 main_machine_learning.py

mkdir -p outputs/entry
cp setup_ml.sh outputs/entry/setup.sh
cp next_ml.sh outputs/entry/next.sh

#cp setup_nn.sh outputs/entry/setup.sh
#cp next_nn.sh outputs/entry/next.sh

cp AUTHORS.txt outputs/entry/
cp LICENSE.txt outputs/entry/
cp dependencies.txt outputs/entry/

mkdir outputs/entry/utils
cp -R utils/*.py outputs/entry/utils/

mkdir outputs/entry/common
cp -R common/*.py outputs/entry/common/

cp *.py outputs/entry
cp answers.txt outputs/entry

cp model.pkl outputs/entry || true
cp weights.h5 outputs/entry || true

cp -R packages outputs/entry/packages

read -p "Is this a dry-run entry? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp DRYRUN outputs/entry/DRY_RUN
fi

cd outputs/entry
zip -r ../entry.zip ./
cd -

echo "Entry was created successfully"
FAILED=NO
