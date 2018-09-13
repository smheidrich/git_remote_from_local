#!/bin/bash
set -e
pushd tests
vagrant up --provision
vagrant ssh -c 'cd /git_remote_from_local && sudo molecule test'
popd # tests
