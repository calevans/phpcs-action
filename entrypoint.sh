#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

echo "Cal's test action:"

set

df -h

ls -lh

pwd

echo "::remove-matcher owner=phpcs::"

exit 0
