REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

build:

install:: typical-roll-test-install
	perl -pi -e 's#VERSION#$(VERSION)#g;' $(ROOT)/$(PKGROOT)/*.t

clean::
