NAME = LilyDev
RELEASE = 0.4

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

debian: $(NAME)-debian-$(RELEASE)
$(NAME)-debian-$(RELEASE): $(DEBIAN_CONTAINER_SRC)
	@echo 'Build Debian container.'
	cd debian && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/$(NAME)-debian-$(RELEASE)

debian-vm: $(NAME)-debian-vm-$(RELEASE).img
$(NAME)-debian-vm-$(RELEASE).img: $(DEBIAN_VM_SRC)
	@echo 'Build Debian virtual machine.'
	cd debian && sudo mkosi -f --checksum --default mkosi.vm --password="" -o $(PWD)/$(NAME)-debian-vm-$(RELEASE).img


# Other images, just in case...
fedora: $(NAME)-fedora-$(RELEASE)
$(NAME)-fedora-$(RELEASE): $(FEDORA_CONTAINER_SRC)
	@echo 'Build Fedora container.'
	cd fedora && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/$(NAME)-fedora-$(RELEASE)

fedora-vm: $(NAME)-fedora-vm-$(RELEASE).img
$(NAME)-fedora-vm-$(RELEASE).img: $(FEDORA_VM_SRC)
	@echo 'Build Fedora virtual machine.'
	cd fedora && sudo mkosi -f --checksum --default mkosi.vm -o $(PWD)/$(NAME)-fedora-vm-$(RELEASE).img


# Archive files to be uploaded to Github
release: $(NAME)-debian-$(RELEASE).tar.xz $(NAME)-debian-vm-$(RELEASE).zip
$(NAME)-debian-$(RELEASE).tar.xz:
	@echo 'Create Debian container archive for Github.'
	sudo tar -vcJf $(NAME)-debian-$(RELEASE).tar.xz $(NAME)-debian-$(RELEASE)

$(NAME)-debian-vm-$(RELEASE).zip:
	@echo 'Create Debian virtual machine archive for Github.'
	sudo zip -v $(NAME)-debian-vm-$(RELEASE).zip SHA256SUMS $(NAME)-debian-vm-$(RELEASE).img

clean:
	sudo rm -rf $(NAME)* SHA256SUMS
