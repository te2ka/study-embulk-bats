#!/usr/bin/env bats

setup() {
  export mode=test
}

teardown() {
  unset mode
}

@test "意図した出力になっていること" {
  cd ${BATS_TEST_DIRNAME}/../../config
  embulk run config-iris.yml.liquid
  run diff ${BATS_TEST_DIRNAME}/actual/iris000.00.csv ${BATS_TEST_DIRNAME}/expected/expected.csv
  [ "$status" -eq 0 ]
  [ "${#lines[*]}" -eq 0 ]
}

@test "環境変数modeが設定されていないと失敗すること" {
  unset mode
  cd ${BATS_TEST_DIRNAME}/../../config
  run embulk run config-iris.yml.liquid
  [ ! "$status" -eq 0 ]
}
