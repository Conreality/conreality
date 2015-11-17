#!/bin/bash

# This is the number of seconds to run each test for
BENCHMARK_QUOTA=1
EXIT_STATUS=0

for benchmark in $(cat bench/bench.itarget)
do
  "./${benchmark}" -quota ${BENCHMARK_QUOTA} || EXIT_STATUS=1
done

exit ${EXIT_STATUS}

