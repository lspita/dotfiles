all: delete restow

restow:
	STOW_FLAG="-R" ./install.sh

delete:
	STOW_FLAG="-D" ./install.sh
