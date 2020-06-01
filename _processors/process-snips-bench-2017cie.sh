#!/usr/bin/env bash
#
# Retrieve and process the snips bench set from 2017-06-custom-intent-engines
#
# 

slug="snips-bench-2017cie"

cd $(dirname $0)

# Make a workspace
mkdir -p 1-original/
mkdir -p 2-processed/

original_base="./1-original/${slug}"
processed="./2-processed/${slug}.csv"

# List of intents
intents="AddToPlaylist BookRestaurant GetWeather PlayMusic RateBook SearchCreativeWork SearchScreeningEvent"
rm -f ${processed}

for intent in $intents; do

    # Retrieve
    original="${original_base}.train_${intent}_full.json"
    curl -s -o "${original}" -C - "https://raw.githubusercontent.com/snipsco/nlu-benchmark/master/2017-06-custom-intent-engines/${intent}/train_${intent}_full.json"

    # pretty print standardize each original
    # cat ${original} | jq '.' > ${original}.pp.json

    # Process
    cat ${original}                                         | # ... 
        jq ".${intent}[][] | map(.text) | join(\"\")"       | # Grab and stitch together the question test
        sed "s/^/\"${slug}\",/g"                            | # Add slug as col 1
        sed "s/$/,\"${intent}\",/g"                         | # Add intent as col 3
        cat >> ${processed}

done


