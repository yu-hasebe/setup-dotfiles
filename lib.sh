#!/usr/bin/env bash
set -euo pipefail

function _info() {
	echo "${@}" >&2
}

## _abspath converts a path (file or directory) to an absolute path.
## Arguments:
##   $1 - relative or absolute path
## Returns:
##   absolute path, or empty string if path does not exist
function _abspath() {
	local _path="${1}"

	if [[ ! -e "${_path}" ]]; then
		echo ""
		return 0
	fi

	if [[ -d "${_path}" ]]; then
		(cd "${_path}" && pwd)
		return 0
	fi

	local _dir
	_dir="$(cd "$(dirname "${_path}")" && pwd)"
	echo "${_dir}/$(basename "${_path}")"
}

function _script_dir() {
	local _script_dir
	_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	echo "${_script_dir}"
}

## _normalize_target converts a given path to an absolute path.
## and returns an empty string if it should be excluded (., .., .git)
## Arguments:
##   $1 - path to normalize
## Returns:
##   absolute path, or empty string if excluded
function _normalize_target() {
	local _path="${1}"
	local _basename
	_basename="$(basename "${_path}")"

	if [[ "${_basename}" == "." || "${_basename}" == ".." || "${_basename}" == ".git" ]]; then
		echo ""
		return 0
	fi

	echo "$(_abspath "${_path}")"
}
