ifneq ("$(ROLLOPTS)", "$(subst licenseserver=,,$(ROLLOPTS))")
  LICENSESERVER = $(subst licenseserver=,,$(filter licenseserver=%,$(ROLLOPTS)))
endif
NAME           = sdsc-intelmpi
VERSION        = 2016.3.210
RELEASE        = 3
PKGROOT        = /opt/intel/$(VERSION)

SRC_SUBDIR     = intelmpi

SOURCE_NAME    = parallel_studio_xe
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 2016_update3
L_MKL_VERSION  = 11.3.3
SOURCE_PKG     = $(SOURCE_NAME)_$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS       = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No \n %define         __prelink_undo_cmd     %{nil}
