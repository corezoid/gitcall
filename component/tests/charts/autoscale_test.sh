#!/usr/bin/env bash
$CZ helm template | sed -n '/autoscale\.yaml/,/Source\:/p'
