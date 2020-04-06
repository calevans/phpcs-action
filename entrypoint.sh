#!/bin/php
exec("git log -n 1 --oneline --abbrev-commit --pretty=format:'%h--%d--%s' | awk -F '--' '{print $3}'", $commitMessage);
print_r($commitMessage);