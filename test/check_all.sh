#!/bin/bash

#echo "CAML_LD_LIBRARY_PATH=${CAML_LD_LIBRARY_PATH}"

EXIT_STATUS=0

for check in $(cat test/check.itarget)
do
  "./${check}" $1 || EXIT_STATUS=1
done

exit ${EXIT_STATUS}
