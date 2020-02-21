#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

time=$(date)
echo ::set-output name=time::$time

echo "Cal's test action:"

set

curl -iv -H 'X-test: $TEST_SECRET' -o delete.me https://calevans.com/

status=$?

echo "::remove-matcher owner=phpcs::"

exit 0
