#! /bin/bash

STOW_IGNORE=".stow-local-ignore"
TARGETS_SCRIPT="targets.sh"

source "$TARGETS_SCRIPT"

if [[ -z $STOW_FLAG ]]; then
	STOW_FLAGS="-R"
fi

readarray -t ignore_list < "$STOW_IGNORE" # read lines of $STOW_IGNORE into $ignore_list
ignore_list+=("$STOW_IGNORE") # append ignore file to list

 # create map of excluded files
declare -A ignore_map
for i in "${ignore_list[@]}"; do
  ignore_map["$i"]=true
done

for package in *; do
  if [[ ${ignore_map["$package"]} == true ]]; then
  	continue
  else
	read -r -a target <<< "${targets["$DEFAULT_TARGET"]}" # convert the string into an array
	
  	if [[ "${targets["$package"]}" ]]; then
  		read -r -a target <<< "${targets["$package"]}" # convert the string into an array
  	fi

	path="${target[0]}"
	use_sudo="${target[1]}"
  	
  	sudo_prefix=""
  	if [[ $use_sudo == true ]]; then
  		sudo_prefix="sudo "
  	fi
  	
  	command="${sudo_prefix}stow --target=$path $STOW_FLAG $package"
	echo "$command"
  	eval $command
  fi
done
