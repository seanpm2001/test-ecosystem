#!/usr/bin/env bats

@test "crystal env" {
  crystal eval 'puts Process.run("env", output: :inherit, error: :inherit)'
  false
}
@test "crystal env shell" {
  crystal eval 'puts Process.run("env", shell: true, output: :inherit, error: :inherit)'
  false
}
@test "crystal find_executable" {
  crystal eval 'puts Process.find_executable("crystal")'
  false
}
@test "run crystal shell" {
  crystal eval 'puts Process.run("crystal", shell: true, output: :inherit, error: :inherit)'
}
@test "run crystal" {
  crystal eval 'puts Process.run("crystal", output: :inherit, error: :inherit)'
}

@test "kemal specs" {
  pushd $REPOS_DIR/kemalcr/kemal
  shards

  crystal spec
  crystal spec --release --no-debug

  popd
}

@test "kemal init" {
  pushd $REPOS_DIR/kemalcr

  crystal init app kemal101
  pushd kemal101

  echo "" >> ./shard.yml
  echo "dependencies:" >> ./shard.yml
  echo "  kemal:" >> ./shard.yml
  echo "    path: $REPOS_DIR/kemalcr/kemal" >> ./shard.yml
  echo "" >> ./shard.yml

  echo 'require "kemal";get "/" { "Hello World!"};Kemal.run' > ./src/kemal101.cr
  shards
  crystal build ./src/kemal101.cr # -D without_openssl

  popd
  popd
}
