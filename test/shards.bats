#!/usr/bin/env bats

function setup_file() {
  load helper/common

  git_checkout https://github.com/crystal-lang/shards
}

function setup() {
  load helper/common
}

@test "test" {
  export USER=shardsuser # required for fossil

  if [ "$RUNNER_OS" = "Windows" ]; then
    $SHARDS install

    $CRYSTAL spec spec/unit --tag ~hg --tag ~fossil

    $SHARDS build
    $CRYSTAL spec spec/integration
  else
    $MAKE test
  fi
}
