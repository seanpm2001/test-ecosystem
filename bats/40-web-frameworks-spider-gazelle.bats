#!/usr/bin/env bats

@test "spider-gazelle build" {
  pushd $REPOS_DIR/spider-gazelle/spider-gazelle
  shards

  crystal build src/app.cr

  popd
}
