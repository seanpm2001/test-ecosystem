#!/usr/bin/env bats

function setup_file() {
  load helper/common.bash

  git_checkout https://github.com/crystal-lang/crystal
}

function setup() {
  load helper/common.bash
}

@test "$CRYSTAL --version" {
  $CRYSTAL --version
}

@test "$CRYSTAL env" {
  $CRYSTAL env
}

@test "crystal manual specs" {
  "bin/crystal${BAT}" spec spec/manual/https_client_spec.cr
}

# @test "crystal compiler" {
#   pushd $REPOS_DIR/crystal-lang/crystal

#   make clean

#   # skip wrapper script in case the crystal compiler points to a wrapper
#   bin_crystal=$(dirname $(dirname $(which crystal)))/.build/crystal
#   if test -f "$bin_crystal"; then
#     mkdir -p .build
#     cp $bin_crystal .build/crystal
#     touch src/compiler/crystal.cr
#   fi

#   make clean_cache crystal
#   CRYSTAL_OPTS="" make .build/std_spec .build/compiler_spec
#   # CRYSTAL_OPTS="" make std_spec compiler_spec

#   popd
# }
