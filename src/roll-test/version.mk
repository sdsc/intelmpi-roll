NAME       = sdsc-intelmpi-roll-test
RELEASE    = 2
PKGROOT    = /root/rolltests

VERSION_SRC = $(REDHAT.ROOT)/src/intelmpi/version.mk
VERSION_INC = version.inc

include $(VERSION_INC)

RPM.EXTRAS = AutoReq:No
