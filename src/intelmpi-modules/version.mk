PACKAGE     = intelmpi
CATEGORY    = mpi

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 7
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
RPM.EXTRAS  = AutoReq:No\nObsoletes:sdsc-intelmpi-modules_gnu,sdsc-intelmpi-modules_intel,sdsc-intelmpi-modules_pgi
RPM.PREFIX  = $(PKGROOT)
