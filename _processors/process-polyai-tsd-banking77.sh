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
# This file has "" around phrases with commas, and no quotes around thouse without. Therefore a 2 pass process helps.
cat ${original1} ${original2} | # ...
    grep -v "^text,category"  | # Remove the header
    grep '^"'                 | # Get the phrases with pre-existing quotes (pass 1)
    grep ","                  | # Remove lines without a comma (empy, " only, missing intent)
    grep -v '^",'             | # Remove malformed lines
    grep -v "but I want to transfer some of the money to my account here.$" | # Remove malformed line with no intent 
    grep -v "I think someone managed to get my card details and use it.$" | # Remove malformed line with no intent / duplicate
    sed 's/""//g'             | # Remove the misc ""
    sed 's/|//g'              | # Remove the one errant |
    sed 's///g'             | # Remove the windows newlines in this set
    sed 's/",/","/g'          | # Add a quote at the front of the intent after the comma
    sed 's/$/"/g'             | # Add a " at the end
    sed "s/^/\"${slug}\",/g"  | # Add slug as col 1
    cat > ${processed}

cat ${original1} ${original2} | # ...
    grep -v "^text,category"  | # Remove the header
    grep -v '^"'              | # Get the phrases withOUT pre-existing quotes (pass 2)
    grep ","                  | # Remove lines without a comma (empy, " only, missing intent)
    grep -v '^",'             | # Remove malformed lines
    grep -v "but I want to transfer some of the money to my account here.$" | # Remove malformed line with no intent 
    grep -v "I think someone managed to get my card details and use it.$" | # Remove malformed line with no intent / duplicate
    sed 's/""//g'             | # Remove the misc ""
    sed 's/|//g'              | # Remove the one errant |
    sed 's///g'             | # Remove the windows newlines in this set
    sed 's/^./"&/g'           | # Add quotes at front (why . + & -> byte sequence err)
    sed 's/,/","/g'           | # Add a quotes before and after the separating comma
    sed 's/$/"/g'             | # Add a " at the end
    sed "s/^/\"${slug}\",/g"  | # Add slug as col 1
    cat >> ${processed}


