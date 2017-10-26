RELEASE = 0.2

DEBIAN_SOURCES = debian/mkosi.debian debian/mkosi.postinst $(wildcard debian/mkosi.extra/*)
FEDORA_SOURCES = fedora/mkosi.fedora fedora/mkosi.postinst $(wildcard fedora/mkosi.extra/*)

.PHONY: all clean debian fedora release vm-fedora
all: debian fedora

debian: lilydev-debian-$(RELEASE)
lilydev-debian-$(RELEASE): $(DEBIAN_SOURCES)
	cd debian && sudo mkosi -f --default mkosi.debian --password="" -o $(PWD)/lilydev-debian-$(RELEASE)

fedora: lilydev-fedora-$(RELEASE)
lilydev-fedora-$(RELEASE): $(FEDORA_SOURCES)
	cd fedora && sudo mkosi -f --default mkosi.fedora --password="" -o $(PWD)/lilydev-fedora-$(RELEASE)

vm-fedora: lilydev-vm-fedora-$(RELEASE).raw
lilydev-vm-fedora-$(RELEASE).raw: $(FEDORA_SOURCES)
	cd fedora && sudo mkosi -f --checksum --default mkosi.fedora-lxqt -o $(PWD)/lilydev-vm-fedora-$(RELEASE).raw

release: lilydev-debian-$(RELEASE).tar.xz lilydev-fedora-$(RELEASE).tar.xz lilydev-vm-fedora-$(RELEASE).zip

lilydev-debian-$(RELEASE).tar.xz:
	sudo tar -vcJf lilydev-debian-$(RELEASE).tar.xz lilydev-debian-$(RELEASE)

lilydev-fedora-$(RELEASE).tar.xz:
	sudo tar -vcJf lilydev-fedora-$(RELEASE).tar.xz lilydev-fedora-$(RELEASE)

lilydev-vm-fedora-$(RELEASE).zip:
	sudo zip -v lilydev-vm-fedora-$(RELEASE).zip SHA256SUMS lilydev-vm-fedora-$(RELEASE).raw

clean:
	sudo rm -rf lilydev* SHA256SUMS
