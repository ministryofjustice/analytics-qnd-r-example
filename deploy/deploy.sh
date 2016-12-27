#!/bin/bash
set -x
# Copyright 2014 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# $1 = the kubernetes context (specified in kubeconfig)
# $2 = directory that contains your kubernetes files to deploy
# $3 = pass in rolling to perform a rolling update

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONTEXT="$1"
DEPLOYDIR="$2"
APPNAME="$3"
GITSHA="$4"

# Expand env vars in k8s YAML
mkdir ${DEPLOYDIR}/run
for f in ${DEPLOYDIR}/*.y*ml; do
  envsubst < $f > ${DEPLOYDIR}/run/$(basename $f)
done

# Apply changes, including Deployment update
~/.kube/kubectl apply -f ${DEPLOYDIR}/run/

# Output Deployment update status until complete
~/.kube/kubectl rollout status -f ${DEPLOYDIR}/run/deployment.yml

echo "Container ${DOCKER_REGISTRY}/${CONTAINER}:git-${GITSHA} deployed to https://${APPNAME}.${BASEAPPHOST}/"

