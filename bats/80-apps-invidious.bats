#!/usr/bin/env bats

@test "invidious specs" {
  pushd $REPOS_DIR/iv-org/invidious
  shards install
  crystal spec
  popd
}

@test "invidious build" {
  pushd $REPOS_DIR/iv-org/invidious
  shards install
  crystal build --warnings all --error-on-warnings --error-trace src/invidious.cr
  popd
}
