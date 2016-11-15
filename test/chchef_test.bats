#!/usr/bin/env bats

export CHEF_HOME="test/fixtures"

source "share/chchef/chchef.sh"

setup() {
  mkdir -p $CHEF_HOME
}

@test "initialize chef directory" {
  touch $CHEF_HOME/knife.rb
  touch $CHEF_HOME/${USER}.pem
  touch $CHEF_HOME/bar-validator.pem

  chchef init foo

  [ -f "$CHEF_HOME/foo/knife.rb" ]
}

@test "switch chef configuration" {
  mkdir -p $CHEF_HOME/bar
  touch $CHEF_HOME/bar/knife.rb
  touch $CHEF_HOME/bar/${USER}.pem
  touch $CHEF_HOME/bar/bar-validator.pem

  chchef bar

  [ -L "$CHEF_HOME/knife.rb" ]
}

teardown() {
  rm -rf $CHEF_HOME
}
