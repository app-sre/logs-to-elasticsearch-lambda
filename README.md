# logs-to-elasticsearch-lambda

Holding repository for logs-to-elasticsearch lambda function 

To trigger new releases, add and upload a new versioning tag (This is a 100% manual step; no automation is intended to do this particular step).

```
# Example
git tag 1.0.0
git push origin 1.0.0
```

By doing this, the app-sre ci-ext jenkins job '[logs-to-elasticsearch-lambda] build tag' will run this repo's 'build_tag.sh" script.

This script will create a new release for this repo, and upload the contents of this repo as a zip file attachment to that release.
