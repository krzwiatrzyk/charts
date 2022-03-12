.ONESHELL:

install-task:
	if [ -f /etc/lsb-release ]; then
	  sudo snap install task --classic
	fi

	if [ -f /etc/redhat-release ]; then
	  echo "Redhat yet not supported!"
	fi

show-os-release:
	@lsb_release -si
	@echo "-------------------"
	@cat /etc/os-release