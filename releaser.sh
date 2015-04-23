#!/bin/sh -e

git fetch --tags
git co develop
git pull origin develop
git co master
git pull origin master
notes=`git log --pretty=format:'* %s' --no-merges`
git merge develop --no-ff -e -m "$notes"
