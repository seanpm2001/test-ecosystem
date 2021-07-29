#!/usr/bin/env bats

@test "athena specs" {
  pushd $REPOS_DIR/athena-framework/athena
  shards

  make spec

  popd
}
