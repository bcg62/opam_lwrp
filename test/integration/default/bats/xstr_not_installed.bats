#!/usr/bin/env bats

@test "oasis package has been installed" {
  [ ! -d "/home/dparfitt/.opam/packages/bats" ]
}
