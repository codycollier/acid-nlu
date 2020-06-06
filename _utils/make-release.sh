#!/usr/bin/env bash
#
# Bundle up files for a release
#
#


# arg 1 or default
rel="${1-v1.0.0}"

relname="acid-nlu-${rel}"

mkdir ${relname}
cp -pr ../data ./${relname}/
cp ../dataset-sources.md ./${relname}/
tar -zcvf ./${relname}.tgz ./${relname}/


