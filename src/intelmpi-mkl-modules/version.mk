PACKAGE     = intelmpi-mkl
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 2
PKGROOT     = /opt/modulefiles/$(CATEGORY)/mkl

VERSION_SRC = $(REDHAT.ROOT)/src/intelmpi/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
RPM.PREFIX  = $(PKGROOT)
