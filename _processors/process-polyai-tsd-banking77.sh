#!/usr/bin/env bash
#
# Retrieve and process the polyai-tsd-banking77 set
#
#

slug="polyai-tsd-banking77"

cd $(dirname $0)

# Make a workspace
mkdir -p 1-original/
mkdir -p 2-processed/

original1="./1-original/${slug}.train.csv"
original2="./1-original/${slug}.test.csv"
processed="./2-processed/${slug}.csv"

# Retrieve the full set
curl -s -o "${original1}" -C - "https://raw.githubusercontent.com/PolyAI-LDN/task-specific-datasets/master/banking_data/train.csv"
curl -s -o "${original2}" -C - "https://raw.githubusercontent.com/PolyAI-LDN/task-specific-datasets/master/banking_data/test.csv"

# Process
cat ${original1} ${original2} | # ...
    sed 's///g'             | # Remove the windows newlines in this set
    sed 's/"//g'              | # Remove all the quotes in the text (inconsistent quoting)
    sed 's/^./"&/g'           | # Now re-add proper csv quoting
    sed 's/$/"/g'             | # ...
    sed 's/,/","/g'           | # ...
    sed 's/"," /, /g'         | # Don't quote commas inside of the utterance text
    sed "s/^/\"${slug}\",/g"  | # Add slug as col 1
    cat > ${processed}
