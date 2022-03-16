#!/usr/bin/env bash

## Download latest Linux OPA release
RELEASE_INFO=`curl --silent https://workato-public.s3.amazonaws.com/agent/release.json`
RELEASE_ARTIFACT_URL=`echo "$RELEASE_INFO" | python -c 'import sys, json; print json.load(sys.stdin)["artifacts"]["linux"]'` || exit 1
RELEASE_CHECKSUM=`echo "$RELEASE_INFO" | python -c 'import sys, json; print json.load(sys.stdin)["checksum"]["linux"]'` || exit 1

cd /home
echo "Downloading artifact: ${RELEASE_ARTIFACT_URL}"
curl --progress-bar -o /home/agent.tar.gz "${RELEASE_ARTIFACT_URL}" || exit 1
CHECKSUM=`md5sum /home/agent.tar.gz | cut -f 1 -d " "`
if [ "$CHECKSUM" != "$RELEASE_CHECKSUM" ]
then
    echo "Artifact checksum does not match: got $CHECKSUM expected $RELEASE_CHECKSUM"
    exit 2
fi

echo "Extracting..."
tar xvzf /home/agent.tar.gz --directory=/opt/workato/ || exit 1

echo "Delete agent.tar.gz..."
rm agent.tar.gz