#!/usr/bin/env bats

# These tests contains some of the most popular Crystal libraries (shards),
# identified via dependent counts on shardbox.org
# They should require no special dependencies.

function setup() {
  load 'helper/common.bash'
}

@test "backtracer.cr" {
  skiponwindows "Specs are failing"
  shard_checkout https://github.com/Sija/backtracer.cr

  $CRYSTAL spec
}

# bats test_tags=openssl
@test "exception_page" {
  skip "Specs are broken (https://github.com/crystal-loot/exception_page/issues/39)"
  skiponwindows "Does not build"
  shard_checkout https://github.com/crystal-loot/exception_page

  $CRYSTAL spec
}

@test "radix" {
  shard_checkout https://github.com/luislavena/radix

  $CRYSTAL spec
}

@test "pool" {
  shard_checkout https://github.com/ysbaddaden/pool

  $CRYSTAL spec
}

@test "habitat" {
  shard_checkout https://github.com/luckyframework/habitat

  $CRYSTAL spec
}

@test "wordsmith" {
  shard_checkout https://github.com/luckyframework/wordsmith

  $CRYSTAL spec
}

@test "future.cr" {
  shard_checkout https://github.com/crystal-community/future.cr

  $CRYSTAL spec
}

@test "baked_file_system" {
  skiponwindows "Does not build"
  shard_checkout https://github.com/schovi/baked_file_system

  $CRYSTAL spec
}

@test "kilt" {
  skiponwindows "Does not build"
  shard_checkout https://github.com/jeromegn/kilt

  $CRYSTAL spec
}

@test "stumpy_core" {
  shard_checkout https://github.com/stumpycr/stumpy_core

  $CRYSTAL spec
}

@test "lucky_task" {
  shard_checkout https://github.com/luckyframework/lucky_task

  $CRYSTAL spec
}

@test "bindata" {
  shard_checkout https://github.com/spider-gazelle/bindata

  $CRYSTAL spec
}

# bats test_tags=openssl
@test "kemal-session" {
  shard_checkout https://github.com/kemalcr/kemal-session

  $CRYSTAL spec
}

@test "teeplate" {
  skip "Wants to sign git commit"
  skiponwindows "Does not build"
  shard_checkout https://github.com/luckyframework/teeplate

  $CRYSTAL spec
}

@test "markd" {
  shard_checkout https://github.com/icyleaf/markd

  $CRYSTAL spec
}

@test "json_mapping.cr" {
  skiponwindows "Does not build"
  shard_checkout https://github.com/crystal-lang/json_mapping.cr

  $CRYSTAL spec
}
