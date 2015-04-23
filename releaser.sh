#!/bin/sh -e

git fetch --tags
git co develop
git pull origin develop
git co master
git pull origin master


git merge develop

TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
NUMBER=`echo $TAG | grep -o "v[0-9]*" | grep -oE "[0-9]+"`
NEXT=$(($NUMBER+1))
RELEASEDATE=$(date +"%d/%m %Y %H:%M")
NUMBER=4
NOTES=`git log v$NUMBER..HEAD --pretty=format:'* %s' --no-merges`
git tag v$NEXT -m "Release v$NEXT
$RELEASEDATE

$NOTES"

git push origin master
git push --tags
