#!/bin/bash

EXIT_STATUS=0

for check in $(cat test/check.itarget)
do
  "./${check}" $1 || EXIT_STATUS=1
done

exit ${EXIT_STATUS}
