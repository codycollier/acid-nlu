#!/usr/bin/env bash
#
# show intents and counts from each set
#


for f in `ls -1 ./2-processed/*`; do

    count=$(cat $f | awk 'BEGIN { FS="\",\"" }; { print $3 }' | sed 's/"$//g' | sort | uniq | wc -l | tr -s ' ')

    echo
    echo "--------------------------------------------------------------------"
    echo ":: (intents:$count) $f"
    echo "--------------------------------------------------------------------"
    cat $f | awk 'BEGIN { FS="\",\"" }; { print $3 }' | sed 's/"$//g' | sort | uniq
    echo

done
