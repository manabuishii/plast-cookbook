#!/usr/bin/env bats
@test "plastall binary is found in PATH" {
    run which plastall
    [ "$status" -eq 0 ]
}
