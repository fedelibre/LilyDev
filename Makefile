RELEASE = 0.1

SOURCES = mkosi.fedora mkosi.postinst $(wildcard mkosi.extra/*)

all: lilydevos-$(RELEASE)

lilydevos-$(RELEASE): $(SOURCES)
	sudo mkosi --default mkosi.fedora --password="" -o lilydevos-$(RELEASE)

.PHONY: release
release:
	sudo tar -cJf lilydevos-$(RELEASE).tar.xz lilydevos-$(RELEASE)

