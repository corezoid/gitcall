#!/usr/bin/env bash
$CZ component generate-config --with-helm ../ > "${CZ_TMP_DIR}/generated_config_with_helm.yaml"
$CZ ops valid-config "${CZ_TMP_DIR}/generated_config_with_helm.yaml" ../schema/helm.json ../schema
