#!/bin/bash

PACKAGES_DIR="packages"

__require() {
	eval "$2" > /dev/null
	if [ $? -eq 0 ]; then
		cat # pass trough
	else
		grep -vE "$1"
	fi
}

__require-command() {
	__require $1 "command -v ${@:2} > /dev/null"
}

__require-path() {
	__require $1 "test -e ${@:2}"
}

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

for package in `ls -1 $PACKAGES_DIR | __packages-filter`; do
	target=`get_package_attribute $package target`
	sudo=`get_package_attribute $package sudo`

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
	echo "$command"
	eval "$command"
done
