REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@
 
build:

install::
	if test "$(COMPILERNAME)" !=  pgi; then \
           mkdir -p -m 755 $(ROOT)/$(PKGROOT); \
           $(MODULE_LOAD_CC); \
           export CC=$(CC); \
	   for V in $(VERSION) $(EXTRA_MODULE_VERSIONS); do \
	     cp *.module $(ROOT)/$(PKGROOT)/$$V; \
	     cp *.version $(ROOT)/$(PKGROOT)/.version.$$V; \
	     perl -pi -e 's#COMPILERNAME#$(COMPILERNAME)#g;' \
	           -e 's#MPINAME#$(MPINAME)#g;' \
	           -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
	           -e 's#ROLLMPI#$(ROLLMPI)#g;' \
	           -e 's#ROLLOPTS#$(ROLLOPTS)#g;' \
	           -e 's#ROLLPY#$(ROLLPY)#g;' \
	           -e "s#VERSION#$$V#g;" \
                   -e 's#CCOMP#$(CC)#g;' \
                   -e 's#CXXCOMP#$(CXX)#g;' \
                   -e 's#F77COMP#$(F77)#g;' \
                   -e 's#F90COMP#$(FC)#g;' \
	       $(ROOT)/$(PKGROOT)/.version.$$V $(ROOT)/$(PKGROOT)/$$V; \
	   done; \
           ln -s $(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/.version; \
        fi





clean::
	rm -f $(VERSION_INC)

