#!/bin/bash

PACKAGES_DIR="packages"

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

for package in $(ls -1 $PACKAGES_DIR); do
	target=$(get_package_attribute $package target)
	sudo=$(get_package_attribute $package sudo)

	case $sudo in
		"true")
			prefix="sudo "
			;;
		"false")
			prefix=""
			;;
		*)
			echo "Invalid sudo value $sudo for package $package" 1>&2
			exit 1
			;;
	esac

	command="${prefix}stow -d $PACKAGES_DIR -t $target $@ $package"
	echo "$command" # debug
	eval "$command"
done
