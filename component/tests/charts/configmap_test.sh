#!/usr/bin/env bash
$CZ helm template | sed -n '/configmap\.yaml/,/Source\:/p'