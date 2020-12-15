#!/usr/bin/env bash
$CZ helm template | sed -n '/deployment\.yaml/,/Source\:/p'
