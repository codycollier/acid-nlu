#!/usr/bin/env bash
#
# Retrieve and process the sebis eval webapps set
#
#

slug="sebis-eval-webapps"

cd $(dirname $0)

# Make a workspace
mkdir -p 1-original/
mkdir -p 2-processed/

original="./1-original/${slug}.WebApplicationsCorpus.json"
processed="./2-processed/${slug}.csv"

# Retrieve the full set
curl -s -o "${original}" -C - "https://raw.githubusercontent.com/sebischair/NLU-Evaluation-Corpora/master/WebApplicationsCorpus.json"

# Process
cat ${original}                                         | # ... 
    jq -r '[.sentences][][] | [.text, .intent] | @csv'  | # Grab just the question text and the intent label
    sed "s/^/\"${slug}\",/g"                            | # Add slug as col 1
    cat > ${processed}


