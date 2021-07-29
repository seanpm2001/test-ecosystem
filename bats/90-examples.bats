#!/usr/bin/env bats

@test "crystal-patterns rebuild" {
  pushd $REPOS_DIR/crystal-community/crystal-patterns

  ./rebuild.sh

  popd
}
