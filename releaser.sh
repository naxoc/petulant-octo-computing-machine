#!/bin/sh -e

git fetch --tags
git co develop
git pull origin develop
git co master
git pull origin master

TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
CURRENT_NUMBER=`echo $TAG | grep -o "v[0-9]*" | grep -oE "[0-9]+"`
NEXT=$(($CURRENT_NUMBER+1))
RELEASEDATE=$(date +"%d/%m %Y %H:%M")
NOTES=`git --no-pager log v$CURRENT_NUMBER..develop --pretty=format:'* %s' --no-merges`
git merge develop --no-ff -e -m "Release v$NEXT
$RELEASEDATE
----
$NOTES
"

git tag v$NEXT
git push origin master
git push --tags
