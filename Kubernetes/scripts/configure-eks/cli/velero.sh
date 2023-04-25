#!/bin/bash

curl --silent --location https://github.com/vmware-tanzu/velero/releases/download/v1.10.2/velero-v1.10.2-linux-amd64.tar.gz | tar xz -C /tmp

sudo mv /tmp/velero-v1.10.2-linux-amd64/velero /usr/local/bin/
