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

## _install creates symlinks pointing to files/directories at the home directory.
## Arguments:
##   $1 - force flag; 0 for skipping existing files, 1 for overwriting them
##   $@ - the list of files/directories to link
function _install() {
	local _force="${1}"
	shift
	local _files=("${@}")

	local _file _target
	for _file in "${_files[@]}"; do
		if [[ ! -e "${_file}" ]]; then
			_info "File or directory not found: ${_file}"
			return 1
		fi

		_target="$HOME/$(basename "${_file}")"

		if [[ -e "${_target}" || -L "${_target}" ]]; then
			if [[ "${_force}" -eq 1 ]]; then
				rm -rf "${_target}"
				_info "⚡ Overwriting existing: ${_target}"
			else
				_info "⚠️ Skipping ${_file}, already exists: ${_target}"
				continue
			fi
		fi

		ln -sf "${_file}" "${_target}"
		_info "🔗 Linked: ${_file}"
	done

	_info "✅ All symlinks created!"
}

## _uninstall deletes symlinks pointing to files/directories at the home directory.
## Arguments:
##   $@ - the list of files/directories to link
function _uninstall() {
	local _files=("${@}")

	local _file _target
	for _file in "${_files[@]}"; do
		_target="$HOME/$(basename "${_file}")"
		if [[ -L "${_target}" ]]; then
			rm "${_target}"
			_info "❌ Removed symlink: ${_target}"
		else
			_info "⚠️ Not a symlink or does not exist: ${_target}"
		fi
	done

	_info "✅ All symlinks removed!"
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

function _show_help() {
	local _files=()
	while IFS= read -r _file; do
		_files+=("${_file}")
	done < <(_target_files)

	echo "Usage: ${0} [-h] [-f] [install|uninstall]"
	echo ""
	echo "Commands:"
	echo "  install   Creates symlinks at $HOME"
	echo "  uninstall Removes symlinks at $HOME"
	echo "Target files:"
	echo "$(printf -- "  - %s\n" "${_files[@]}")"
	echo "Options:"
	echo "  -h        Shows this help message"
	echo "  -f        Forcibly overwrites exsiting files or directories when creating symlinkns (install only)"
	echo "  -t        Specifies the target files or directories to be replaced with symlinks"
}

function main() {
	local _force=0 _help=0 _targets=() _parsing_target=0 _subcommand=""
	while [[ "${#}" -gt 0 ]]; do
		case "${1}" in
		-h)
			_parsing_target=0
			_help=1
			;;
		-f)
			_parsing_target=0
			_force=1
			;;
		-t)
			_parsing_target=1
			;;
		install | uninstall)
			_parsing_target=0
			_subcommand="${1}"
			;;
		*)
			if [[ "${_parsing_target}" -eq 1 ]]; then
                local _normalized="$(_normalize_target "${1}")"
                if [[ -n "${_normalized}" ]]; then
                    _targets+=("${_normalized}")
                fi
			else
				_info "invalid args: ${1}"
				return 1
			fi
			;;
		esac
		shift
	done

	if [[ "${_help}" -eq 1 ]]; then
		_show_help
		return 0
	fi

	if [[ "${#_targets[@]}" -eq 0 ]]; then
        _info "no targets specified; use -t to specifiy target files"
        return 1
	fi

	(
		cd "$(_script_dir)"

		case "${_subcommand}" in
		install) _install "${_force}" "${_targets[@]}" || exit 1 ;;
		uninstall) _uninstall "${_targets[@]}" || exit 1 ;;
		*)
			echo "invalid subcommand: ${_subcommand}"
			exit 1
			;;
		esac
	) || return 1
}

main "${@:-}"
