#!/usr/bin/env bats

@test "opam binary is found in PATH" {
  run which opam 
  [ "$status" -eq 0 ]
}
