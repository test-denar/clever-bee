#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://dev-api.stackbit.com/project/5de64bbf600c9a0012faabfa/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://dev-api.stackbit.com/pull/5de64bbf600c9a0012faabfa 
fi
curl -s -X POST https://dev-api.stackbit.com/project/5de64bbf600c9a0012faabfa/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://dev-api.stackbit.com/project/5de64bbf600c9a0012faabfa/webhook/build/publish > /dev/null
