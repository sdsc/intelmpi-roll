REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

build:
	perl -pi -e 's#L_MKL_VERSION#L_MKL_VERS#g;' $(ROOT)/$(PKGROOT)/*.t

install:: typical-roll-test-install
	perl -pi -e 's#L_MKL_VERS#$(L_MKL_VERSION)#g;' $(ROOT)/$(PKGROOT)/*.t
	perl -pi -e 's#ROLLNAME#$(ROLLNAME)#' $(ROOT)/$(PKGROOT)/*.t

clean::
