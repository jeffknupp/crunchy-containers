#!/bin/bash

# Copyright 2016 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# 
# this example creates the metrics backends with NFS volumes
# for storing their data
#

source $BUILDBASE/examples/envvars.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh

envsubst <  $DIR/grafana-pv.json  | oc create -f -
envsubst <  $DIR/prometheus-pv.json | oc create -f -

oc create -f $DIR/grafana-pvc.json
oc create -f $DIR/prometheus-pvc.json

oc process -f $DIR/prometheus-nfs.json -v CCP_IMAGE_TAG=$CCP_IMAGE_TAG | oc create -f -
oc process -f $DIR/promgateway.json -v CCP_IMAGE_TAG=$CCP_IMAGE_TAG | oc create -f -
oc process -f $DIR/grafana-nfs.json -v CCP_IMAGE_TAG=$CCP_IMAGE_TAG | oc create -f -
