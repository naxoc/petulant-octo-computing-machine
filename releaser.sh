#!/bin/sh -e

git fetch --tags
git co develop
git pull origin develop
git co master
git pull origin master

TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
#  | grep -o "v[0-9]+" | grep -oE "[0-9]"`
NUMBER=`echo $TAG | grep -o "v[0-9]*" | grep -oE "[0-9]+"`
NEXT=$(($NUMBER+1))
RELEASEDATE=$(date +"%d/%m %Y %H:%M")

NOTES=`git log --pretty=format:'* %s' --no-merges`
git merge develop --no-ff -e -m "Release v$NEXT
$RELEASEDATE

$NOTES"

git tag v$NEXT
git push origin master
git push --tags
