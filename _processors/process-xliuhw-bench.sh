#!/usr/bin/env bash
#
# Retrieve and process the xliuhw-bench set
#
#

slug="xliuhw-bench"

cd $(dirname $0)

# Make a workspace
mkdir -p 1-original/
mkdir -p 2-processed/

# original="./1-original/${slug}.paraphrases_and_intents_26k_normalised_all.csv"
original="./1-original/${slug}.NLU-Data-Home-Domain-Annotated-All.csv"
processed="./2-processed/${slug}.csv"

# Retrieve the full set
# curl -s -o "${original}" -C - "https://raw.githubusercontent.com/xliuhw/NLU-Evaluation-Data/master/Collected-Original-Data/paraphrases_and_intents_26k_normalised_all.csv"
curl -s -o "${original}" -C - "https://raw.githubusercontent.com/xliuhw/NLU-Evaluation-Data/master/AnnotatedData/NLU-Data-Home-Domain-Annotated-All.csv"

# Process
cat ${original}                                                             | # ... 
    grep -v "^userid;answerid;scenario;intent"                              | # Remove the header
    awk 'BEGIN { FS = ";" } ; { print "\"" $10 "\",\"" $3 "." $4 "\""}'     | # Pull the scenario (domain/intent), intent (subintent), and phrase
    sed "s/^/\"${slug}\",/g"                                                | # Add slug as col 1
    cat > ${processed}


