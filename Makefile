all: restow

restow:
	STOW_FLAG="-R" ./main.sh

delete:
	STOW_FLAG="-D" ./main.sh
