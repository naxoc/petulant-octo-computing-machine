#!/bin/sh -e

git fetch --tags
git co develop
git pull origin develop
git co master
git pull origin master


git merge develop

TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
CURRENT_NUMBER=`echo $TAG | grep -o "v[0-9]*" | grep -oE "[0-9]+"`
NEXT=$(($CURRENT_NUMBER+1))
RELEASEDATE=$(date +"%d/%m %Y %H:%M")
NOTES=`git log v$CURRENT_NUMBER..HEAD --pretty=format:'* %s' --no-merges`
echo "Release v$NEXT
$RELEASEDATE

$NOTES
" > CHANGELOG.md
$EDITOR CHANGELOG.md

git tag -a v$NEXT -F=CHANGELOG.md

git push origin master
git push --tags
