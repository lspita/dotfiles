#! /bin/bash

PACKAGES_DIR="packages"
if [[ -z "${STOW_ACTION}" ]]; then
	STOW_ACTION="-R" # restow by default
fi

source ./packages.sh # load package attributes
default_target=${HOME}
default_sudo=0

get_package_attribute() {
	local package_attr_var="${1}_${2}"

	if [[ ! -v ${package_attr_var} || -z "${!package_attr_var}" ]]; then
		package_attr_var="default_${2}"
	fi

	echo ${!package_attr_var}
}

for package_dir in ${PACKAGES_DIR}/*; do
	PACKAGE=`basename ${package_dir}`

	TARGET_PATH=`get_package_attribute ${PACKAGE} target`
	USE_SUDO=`get_package_attribute ${PACKAGE} sudo`

	if [ ${USE_SUDO} -eq 0 ]; then
		SUDO_PREFIX=""
	else
		SUDO_PREFIX="sudo "
	fi

	command="${SUDO_PREFIX}stow -d ${PACKAGES_DIR} -t ${TARGET_PATH} ${STOW_ACTION} ${PACKAGE}"
	echo ${command}
	eval ${command}
done
