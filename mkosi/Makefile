NAME = LilyDev
RELEASE = 3

DEBIAN_CONTAINER_SRC = $(wildcard debian/mkosi.container.d/*) $(wildcard debian/mkosi.extra) debian/mkosi.postinst
DEBIAN_VM_SRC = $(wildcard debian/mkosi.vm.d/*) $(wildcard debian/mkosi.extra) debian/mkosi.postinst

FEDORA_CONTAINER_SRC = $(wildcard fedora/mkosi.container.d/*) $(wildcard fedora/mkosi.extra) fedora/mkosi.postinst
FEDORA_VM_SRC = $(wildcard fedora/mkosi.vm.d/*) $(wildcard fedora/mkosi.extra) fedora/mkosi.postinst

.PHONY: clean debian debian-vm fedora fedora-vm help images release

help:
	@echo 'Makefile to build LilyDev images                                   '
	@echo '                                                                   '
	@echo 'Usage:                                                             '
	@echo '   make images           Generate images to be released.           '
	@echo '   make release          Create archive files.                     '
	@echo '   make clean            Remove all generated files.               '
	@echo '   make help             Print this help.                          '
	@echo '                                                                   '

# Images to be released and uploaded on Github.
images: debian debian-vm

debian: $(NAME)-$(RELEASE)-debian
$(NAME)-$(RELEASE)-debian: $(DEBIAN_CONTAINER_SRC)
	@echo 'Build Debian container.'
	cd debian && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/$(NAME)-$(RELEASE)-debian

debian-vm: $(NAME)-$(RELEASE)-debian-vm.img
$(NAME)-$(RELEASE)-debian-vm.img: $(DEBIAN_VM_SRC)
	@echo 'Build Debian virtual machine.'
	cd debian && sudo mkosi -f --checksum --default mkosi.vm --password="" -o $(PWD)/$(NAME)-$(RELEASE)-debian-vm.img


# Other images, just in case...
fedora: $(NAME)-$(RELEASE)-fedora
$(NAME)-$(RELEASE)-fedora: $(FEDORA_CONTAINER_SRC)
	@echo 'Build Fedora container.'
	cd fedora && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/$(NAME)-$(RELEASE)-fedora

fedora-vm: $(NAME)-$(RELEASE)-fedora-vm.img
$(NAME)-$(RELEASE)-fedora-vm.img: $(FEDORA_VM_SRC)
	@echo 'Build Fedora virtual machine.'
	cd fedora && sudo mkosi -f --checksum --default mkosi.vm -o $(PWD)/$(NAME)-$(RELEASE)-fedora-vm.img


# Archive files to be uploaded to Github
release: $(NAME)-$(RELEASE)-debian.tar.xz $(NAME)-$(RELEASE)-debian-vm.zip
$(NAME)-$(RELEASE)-debian.tar.xz:
	@echo 'Create Debian container archive for Github.'
	sudo tar -vcJf $(NAME)-$(RELEASE)-debian.tar.xz $(NAME)-$(RELEASE)-debian

$(NAME)-$(RELEASE)-debian-vm.zip:
	@echo 'Create Debian virtual machine archive for Github.'
	sudo zip -v $(NAME)-$(RELEASE)-debian-vm.zip SHA256SUMS $(NAME)-$(RELEASE)-debian-vm.img

clean:
	sudo rm -rf $(NAME)* SHA256SUMS
