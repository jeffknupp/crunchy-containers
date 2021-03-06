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

oc delete dc pg-replica-rc-dc
oc delete service pg-master-rc-dc
oc delete service pg-replica-rc-dc
oc delete pod pg-master-rc-dc
oc delete pod -l name=pg-replica-rc-dc
oc delete pod -l name=pg-master-rc-dc
$BUILDBASE/examples/waitforterm.sh pg-master-rc-dc oc
