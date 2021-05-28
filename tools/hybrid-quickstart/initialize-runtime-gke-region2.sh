#!/bin/bash

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

QUICKSTART_ROOT="$( cd "$(dirname "$0")" || exit >/dev/null 2>&1 ; pwd -P )"
export QUICKSTART_ROOT

ENV_NAME=${ENV_NAME:="test1"}
ENV_GROUP_NAME=${ENV_GROUP_NAME:="test"}

source "$QUICKSTART_ROOT/steps.sh"

# configure installation
set_config_params

# create a minimal GKE cluster with a single node pool
create_gke_cluster

# install Anthos service mesh and certmanager
install_asm_and_certmanager

# install the Apigee runtime
install_runtime_region2 $ENV_NAME $ENV_GROUP_NAME

# deploy an example proxy to the given environment
deploy_example_proxy $ENV_NAME $ENV_GROUP_NAME
