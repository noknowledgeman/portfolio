#!/bin/bash

# TODO: make this env instead
BASE_PATH="/"

cat > src/config.gleam << EOF
//// GENERATED FILE - do not edit. See scripts/gen_config.sh
pub const base_path = "${BASE_PATH}"
EOF
