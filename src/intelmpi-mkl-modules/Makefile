REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

build:

# Slight difference from other rolls since we're picking up L_MKL_VERSION,
# instead of the source package VERSION.
$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'L_MKL_VERSION.*=' $(VERSION_SRC) | sed 's/L_MKL_//' > $@
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

install::
	# Additional replacement required for the MKL modulefile
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	cp *.module $(ROOT)/$(PKGROOT)/$(L_MKL_VERSION)
	cp *.version $(ROOT)/$(PKGROOT)/.version.$(L_MKL_VERSION)
	perl -pi -e 's#COMPILERNAME#$(COMPILERNAME)#g;' \
                   -e 's#MPINAME#$(MPINAME)#g;' \
                   -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
                   -e 's#ROLLMPI#$(ROLLMPI)#g;' \
                   -e 's#ROLLOPTS#$(ROLLOPTS)#g;' \
                   -e 's#ROLLPY#$(ROLLPY)#g;' \
                   -e "s#VERSION#$(L_MKL_VERSION)#g;" \
         $(ROOT)/$(PKGROOT)/.version.$$V $(ROOT)/$(PKGROOT)/$(L_MKL_VERSION)
	 perl -pi -e 's/INTELVER/$(VERSION)/g' $(ROOT)/$(PKGROOT)/$(L_MKL_VERSION)

clean::
	rm -f $(VERSION_INC)
