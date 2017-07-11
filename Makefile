RELEASE = 0.1

SOURCES = mkosi.fedora mkosi.postinst $(wildcard mkosi.extra/*)

all: lilydevos-$(RELEASE) lilydevos-vm-$(RELEASE)

lilydevos-$(RELEASE): $(SOURCES)
	sudo mkosi --default mkosi.fedora --password="" -o lilydevos-$(RELEASE)

lilydevos-vm-$(RELEASE): $(SOURCES)
	sudo mkosi --checksum --default mkosi.fedora-lxqt -o lilydevos-vm-$(RELEASE).raw

.PHONY: release
release:
	sudo tar -cJf lilydevos-$(RELEASE).tar.xz lilydevos-$(RELEASE)

