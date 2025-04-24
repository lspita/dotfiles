all: restow

stow:
	./main.sh -S

restow:
	./main.sh -R

delete:
	./main.sh -D
