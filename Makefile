all: restow

restow:
	STOW_FLAGS="-R" ./main.sh

delete:
	STOW_FLAGS="-D" ./main.sh
