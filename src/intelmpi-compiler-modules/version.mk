PACKAGE     = intel
CATEGORY    = compilers

NAME        = sdsc-intelmpi-compiler-modules
RELEASE     = 1
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/intelmpi/version.mk
VERSION_INC = version.inc

include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
RPM.PREFIX  = $(PKGROOT)
