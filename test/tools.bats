#!/usr/bin/env bats

function setup() {
  load helper/common
}

@test "crystal-ameba/ameba" {
  skiponwindows "Timeout"
  shard_checkout https://github.com/crystal-ameba/ameba

  crystal_spec
}
