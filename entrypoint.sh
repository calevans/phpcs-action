#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

echo "Cal's test action:"
echo "=================="

echo " "
echo " Call to endpoint:"
echo "======================="

curl -iv https://dive.calevans.com/work/capture.php


echo " "
echo " Environment Variables:"
echo "======================="

set

echo " "
echo " Mount Points :"
echo "==============="

df -h

echo " "
echo " Current Dir and contents :"
echo "==========================="

pwd

echo "--- "

ls -lh

echo " "
echo " Python info :"
echo "==========================="
python -version

echo " "
echo " IP info :"
echo "==========================="
ifconfig

echo " "
echo " PHP info :"
echo "==========================="
php -i
echo " "

echo "::remove-matcher owner=phpcs::"

exit 0
