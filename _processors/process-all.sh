#!/usr/bin/env bash

date

./process-clinc150.sh
./process-polyai-tsd-banking77.sh
./process-sebis-eval-askubuntu.sh
./process-sebis-eval-chatbot.sh
./process-sebis-eval-webapps.sh
./process-snips-bench-2017cie.sh
./process-xliuhw-bench.sh

echo "done."

