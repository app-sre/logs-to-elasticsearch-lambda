#!/bin/bash

TAG=$(echo $GIT_BRANCH|cut -d"/" -f3)
GIT_ORG=$(echo $GIT_URL|cut -d":" -f2|cut -d"/" -f1)
GIT_REPO=$(echo $GIT_URL|cut -d"/" -f2|cut -d"." -f1)
ZIP_NAME=LogsToElasticsearch.zip

generate_post_data() {
  cat << EOF
{
  "tag_name": "$TAG",
  "target_commitish": "$GIT_COMMIT",
  "name": "$TAG",
  "body": "new version $TAG",
  "draft": false,
  "prerelease": false
}
EOF
}

UPLOAD_URL=$(curl -d "$(generate_post_data)" -H "Authorization: token $GITHUB_TOKEN" -X POST "https://api.github.com/repos/$GIT_ORG/$GIT_REPO/releases"|grep upload_url|cut -d'"' -f4|cut -d'{' -f1)

rm $ZIP_NAME
zip $ZIP_NAME index.js

curl -H "Authorization: token $GITHUB_TOKEN" -X POST -H "Content-Type:application/zip" --data-binary @$ZIP_NAME "$UPLOAD_URL?name=$ZIP_NAME"
