#!/usr/bin/env bash
#
# Retrieve and process the clinc150 set
#
#

slug="clinc150"

echo "Extracting: ${slug}..."

cd $(dirname $0)

# Make a workspace
mkdir -p 1-original/
mkdir -p 2-processed/

original="./1-original/${slug}.data_full.json"
processed="./2-processed/${slug}.csv"

# Retrieve the full set
curl -s -o "${original}" -C - "https://raw.githubusercontent.com/clinc/oos-eval/master/data/data_full.json"

# Process
cat ${original}                              | # ... 
    jq -r '[.val, .train, .test][][] | @csv' |  # Grab only the non oos labeled intent data 
    sed 's/""//g'                            |  # Remove the inconsistent double double quotes
    sed "s/^/\"${slug}\",/g"                 |  # Add slug as col 1
    cat > ${processed}


