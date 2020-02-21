#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

time=$(date)
echo ::set-output name=time::$time
echo "Cal Was Here!"
status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
