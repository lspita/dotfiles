#!/bin/bash

PACKAGES_DIR="packages"
PACKAGES_LIST=`ls -1 $PACKAGES_DIR`

__require-command() {
	if command -v $1 > /dev/null; then
		PACKAGES_LIST=`echo $PACKAGES_LIST | grep -vE "$2"`
	fi
}

source ./overrides.sh

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

for package in $PACKAGES_LIST; do
	target=`get_package_attribute $package target`
	sudo=`get_package_attribute $package sudo`

	if [ $sudo == true ]; then
		prefix="sudo "
	elif [ $sudo == false ]; then
		prefix=""
	else
		echo "Invalid sudo value $sudo for package $package" 1>&2
		exit 1
	fi

	command="${prefix}stow -d $PACKAGES_DIR -t $target $@ $package"
	echo "$command"
	eval "$command"
done
