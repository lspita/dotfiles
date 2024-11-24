all: restow

restow:
	STOW_ACTION="-R" ./main.sh

delete:
	STOW_ACTION="-D" ./main.sh
