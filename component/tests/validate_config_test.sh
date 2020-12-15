#!/usr/bin/env bash
$CZ component generate-release ../ > "${CZ_TMP_DIR}/generated_release.yaml"
$CZ ops valid-config "${CZ_TMP_DIR}/generated_release.yaml" ../schema/main.json ../schema