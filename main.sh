#!/bin/bash

PACKAGES_DIR="packages"
FLAGS=$@

source ./options.sh

get_package_attribute() {
	local package="$1"
	local table="$2"

	declare -n table_ref="$table"

	if [[ -z "${table_ref[$package]}" ]]; then
		echo "${table_ref[default]}"
	else
		echo "${table_ref[$package]}"
	fi
}

__create-command() {
	echo "${1:+"$1 "}stow -d $PACKAGES_DIR -t $target ${FLAGS}${2:+" ${@:2}"} $package"
}

for package in $(ls -1 $PACKAGES_DIR); do
	target=$(get_package_attribute $package target)
	mode=$(get_package_attribute $package mode)
	case $mode in
		"normal")
			command=$(__create-command)
			;;
		"sudo")
			command=$(__create-command "sudo")
			;;
		*)
			echo "Invalid mode $sudo for package $package" 1>&2
			exit 1
			;;
	esac

	echo "$command" # debug
	eval "$command"
done
