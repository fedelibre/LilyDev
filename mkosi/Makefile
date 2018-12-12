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

debian: lilydev-debian-$(RELEASE)
lilydev-debian-$(RELEASE): $(DEBIAN_CONTAINER_SRC)
	@echo 'Build Debian container.'
	cd debian && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/lilydev-debian-$(RELEASE)

debian-vm: lilydev-debian-vm-$(RELEASE).raw
lilydev-debian-vm-$(RELEASE).raw: $(DEBIAN_VM_SRC)
	@echo 'Build Debian virtual machine.'
	cd debian && sudo mkosi -f --checksum --default mkosi.vm --password="" -o $(PWD)/lilydev-debian-vm-$(RELEASE).raw


# Other images, just in case...
fedora: lilydev-fedora-$(RELEASE)
lilydev-fedora-$(RELEASE): $(FEDORA_CONTAINER_SRC)
	@echo 'Build Fedora container.'
	cd fedora && sudo mkosi -f --default mkosi.container --password="" -o $(PWD)/lilydev-fedora-$(RELEASE)

fedora-vm: lilydev-vm-fedora-$(RELEASE).raw
lilydev-vm-fedora-$(RELEASE).raw: $(FEDORA_VM_SRC)
	@echo 'Build Fedora virtual machine.'
	cd fedora && sudo mkosi -f --checksum --default mkosi.vm -o $(PWD)/lilydev-fedora-vm-$(RELEASE).raw


release: lilydev-debian-$(RELEASE).tar.xz lilydev-debian-vm-$(RELEASE).zip
lilydev-debian-$(RELEASE).tar.xz:
	@echo 'Create Debian container archive for Github.'
	sudo tar -vcJf lilydev-debian-$(RELEASE).tar.xz lilydev-debian-$(RELEASE)

lilydev-debian-vm-$(RELEASE).zip:
	@echo 'Create Debian virtual machine archive for Github.'
	sudo zip -v lilydev-debian-vm-$(RELEASE).zip SHA256SUMS lilydev-debian-vm-$(RELEASE).raw

clean:
	sudo rm -rf lilydev* SHA256SUMS
