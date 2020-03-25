#!/usr/bin/env bats

@test "kemal specs" {
  pushd $REPOS_DIR/kemalcr/kemal
  shards

  crystal spec $CRYSTAL_BUILD_OPTS
  crystal spec $CRYSTAL_BUILD_OPTS --release --no-debug

  popd
}

@test "kemal init" {
  pushd $REPOS_DIR/kemalcr

  crystal init app kemal101
  pushd kemal101

  mkdir ./lib

  echo "" >> ./shard.yml
  echo "dependencies:" >> ./shard.yml
  echo "  kemal:" >> ./shard.yml
  echo "    path: $REPOS_DIR/kemalcr/kemal" >> ./shard.yml
  echo "" >> ./shard.yml

  echo 'require "kemal";get "/" { "Hello World!"};Kemal.run' > ./src/kemal101.cr
  shards
  crystal build ./src/kemal101.cr $CRYSTAL_BUILD_OPTS # -D without_openssl

  popd
  popd
}

@test "lucky specs" {
  pushd $REPOS_DIR/luckyframework/lucky
  shards
  rm -rf ./lib/db && ln -s $REPOS_DIR/crystal-lang/crystal-db ./lib/db
  rm -rf ./lib/pg && ln -s $REPOS_DIR/will/crystal-pg ./lib/pg
  rm -rf ./lib/lucky_cli && ln -s $REPOS_DIR/luckyframework/lucky_cli ./lib/lucky_cli

  crystal spec # $CRYSTAL_BUILD_OPTS # due to #{(distance / 30).round.to_i} months ...

  popd
}

@test "lucky build cli" {
  pushd $REPOS_DIR/luckyframework/lucky_cli
  shards

  crystal build src/lucky.cr $CRYSTAL_BUILD_OPTS --release --no-debug

  popd
}

@test "lucky avram specs" {
  pushd $REPOS_DIR/luckyframework/avram
  shards
  rm -rf ./lib/db && ln -s $REPOS_DIR/crystal-lang/crystal-db ./lib/db
  rm -rf ./lib/pg && ln -s $REPOS_DIR/will/crystal-pg ./lib/pg
  rm -rf ./lib/lucky_cli && ln -s $REPOS_DIR/luckyframework/lucky_cli ./lib/lucky_cli

  ln -s $REPOS_DIR/luckyframework/lucky_cli/lucky ./lucky
  export DATABASE_URL="postgres://postgres@$POSTGRES_HOST:5432/lucky_record_test"

  crystal run tasks.cr $CRYSTAL_BUILD_OPTS -- db.create
  crystal run tasks.cr $CRYSTAL_BUILD_OPTS -- db.migrate
  crystal run tasks.cr $CRYSTAL_BUILD_OPTS -- db.rollback_all
  crystal run tasks.cr $CRYSTAL_BUILD_OPTS -- db.migrate.one
  crystal run tasks.cr $CRYSTAL_BUILD_OPTS -- db.migrate
  crystal spec $CRYSTAL_BUILD_OPTS
  shards build $CRYSTAL_BUILD_OPTS

  unset DATABASE_URL

  popd
}

@test "lucky init" {
  pushd $REPOS_DIR/luckyframework

  ./lucky_cli/lucky init lucky101
  pushd lucky101

  shards
  rm -rf ./lib/lucky && ln -s $REPOS_DIR/luckyframework/lucky ./lib/lucky

  shards build $CRYSTAL_BUILD_OPTS

  popd
  popd
}

@test "amber granite specs" {
  pushd $REPOS_DIR/amberframework/granite
  shards
  rm -rf ./lib/db && ln -s $REPOS_DIR/crystal-lang/crystal-db ./lib/db
  rm -rf ./lib/mysql && ln -s $REPOS_DIR/crystal-lang/crystal-mysql ./lib/mysql
  rm -rf ./lib/pg && ln -s $REPOS_DIR/will/crystal-pg ./lib/pg
  rm -rf ./lib/sqlite3 && ln -s $REPOS_DIR/crystal-lang/crystal-sqlite3 ./lib/sqlite3

  export PG_DATABASE_URL="postgres://postgres:@$POSTGRES_HOST:5432/postgres"
  export MYSQL_DATABASE_URL="mysql://root@$MYSQL_HOST:3306/test_granite"
  export SQLITE_DATABASE_URL="sqlite3:./test.db"

  export CURRENT_ADAPTER="sqlite"
  crystal spec $CRYSTAL_BUILD_OPTS

  export CURRENT_ADAPTER="mysql"
  crystal spec $CRYSTAL_BUILD_OPTS

  export CURRENT_ADAPTER="pg"
  crystal spec $CRYSTAL_BUILD_OPTS

  unset PG_DATABASE_URL
  unset MYSQL_DATABASE_URL
  unset SQLITE_DATABASE_URL
  unset CURRENT_ADAPTER

  popd
}

@test "amber specs (build)" {
  pushd $REPOS_DIR/amberframework/amber

  shards
  rm -rf ./lib/db && ln -s $REPOS_DIR/crystal-lang/crystal-db ./lib/db
  rm -rf ./lib/mysql && ln -s $REPOS_DIR/crystal-lang/crystal-mysql ./lib/mysql
  rm -rf ./lib/pg && ln -s $REPOS_DIR/will/crystal-pg ./lib/pg
  rm -rf ./lib/sqlite3 && ln -s $REPOS_DIR/crystal-lang/crystal-sqlite3 ./lib/sqlite3

  shards build $CRYSTAL_BUILD_OPTS
  ./bin/amber -v

  export CI="true"
  export AMBER_ENV="test"
  export REDIS_URL="redis://$REDIS_HOST:6379"
  export DATABASE_URL="postgres://postgres@$POSTGRES_HOST:5432/amber_test"

  # unable to run specs because spec/build_spec_[granite|crecto].cr:23/49
  # expect localhost database instead of DATABASE_URL
  crystal build ./spec/build_spec_granite.cr $CRYSTAL_BUILD_OPTS

  # Environment file not found for ./config/environments/production
  crystal build ./spec/amber/**.cr $CRYSTAL_BUILD_OPTS

  unset CI
  unset AMBER_ENV
  unset REDIS_URL
  unset DATABASE_URL

  popd
}

@test "amber init" {
  pushd $REPOS_DIR/amberframework

  ./amber/bin/amber new amber101
  pushd amber101
  shards
  rm -rf ./lib/db && ln -s $REPOS_DIR/crystal-lang/crystal-db ./lib/db
  rm -rf ./lib/mysql && ln -s $REPOS_DIR/crystal-lang/crystal-mysql ./lib/mysql
  rm -rf ./lib/pg && ln -s $REPOS_DIR/will/crystal-pg ./lib/pg
  rm -rf ./lib/sqlite3 && ln -s $REPOS_DIR/crystal-lang/crystal-sqlite3 ./lib/sqlite3
  rm -rf ./lib/amber && ln -s $REPOS_DIR/amberframework/amber ./lib/amber

  shards build $CRYSTAL_BUILD_OPTS

  popd
  popd
}