ifneq ("$(ROLLOPTS)", "$(subst licenseserver=,,$(ROLLOPTS))")
  LICENSESERVER = $(subst licenseserver=,,$(filter licenseserver=%,$(ROLLOPTS)))
endif
NAME               = sdsc-intelmpi
VERSION            = 2018.1.163
RELEASE            = 2
PKGROOT            = /opt/intel/$(VERSION)

SRC_SUBDIR         = intelmpi


CPP_NAME           = parallel_studio_xe
CPP_SUFFIX         = tgz
CPP_VERSION        = 2018_update1_composer_edition_for_cpp
CPP_PKG            = $(CPP_NAME)_$(CPP_VERSION).$(CPP_SUFFIX)
CPP_DIR            = $(CPP_PKG:%.$(CPP_SUFFIX)=%)
SOURCE_DIR         = $(CPP_DIR)

FORTRAN_NAME       = parallel_studio_xe
FORTRAN_SUFFIX     = tgz
FORTRAN_VERSION    = 2018_update1_composer_edition_for_fortran
FORTRAN_PKG        = $(FORTRAN_NAME)_$(FORTRAN_VERSION).$(FORTRAN_SUFFIX)
FORTRAN_DIR        = $(FORTRAN_PKG:%.$(FORTRAN_SUFFIX)=%)

ADVISOR_NAME       = advisor
ADVISOR_SUFFIX     = tar.gz
ADVISOR_VERSION    = 2018_update1
ADVISOR_PKG        = $(ADVISOR_NAME)_$(ADVISOR_VERSION).$(ADVISOR_SUFFIX)
ADVISOR_DIR        = $(ADVISOR_PKG:%.$(ADVISOR_SUFFIX)=%)

INSPECTOR_NAME      = inspector
INSPECTOR_SUFFIX    = tar.gz
INSPECTOR_VERSION   = 2018_update1
INSPECTOR_PKG       = $(INSPECTOR_NAME)_$(INSPECTOR_VERSION).$(INSPECTOR_SUFFIX)
INSPECTOR_DIR       = $(INSPECTOR_PKG:%.$(INSPECTOR_SUFFIX)=%)

L_ITAC_P_NAME       = l_itac_p
L_ITAC_P_SUFFIX     = tgz
L_ITAC_P_VERSION    = 2018.1.017
L_ITAC_P_PKG        = $(L_ITAC_P_NAME)_$(L_ITAC_P_VERSION).$(L_ITAC_P_SUFFIX)
L_ITAC_P_DIR        = $(L_ITAC_P_PKG:%.$(L_ITAC_P_SUFFIX)=%)

L_TBB_NAME          = l_tbb
L_TBB_SUFFIX        = tgz
L_TBB_VERSION       = 2018.1.163
L_TBB_PKG           = $(L_TBB_NAME)_$(L_TBB_VERSION).$(L_TBB_SUFFIX)
L_TBB_DIR           = $(L_TBB_PKG:%.$(L_TBB_SUFFIX)=%)

L_MKL_NAME          = l_mkl
L_MKL_SUFFIX        = tgz
L_MKL_VERSION       = 2018.1.163
L_MKL_PKG           = $(L_MKL_NAME)_$(L_MKL_VERSION).$(L_MKL_SUFFIX)
L_MKL_DIR           = $(L_MKL_PKG:%.$(L_MKL_SUFFIX)=%)

L_MPI_NAME          = l_mpi
L_MPI_SUFFIX        = tgz
L_MPI_VERSION       = 2018.1.163
L_MPI_PKG           = $(L_MPI_NAME)_$(L_MPI_VERSION).$(L_MPI_SUFFIX)
L_MPI_DIR           = $(L_MPI_PKG:%.$(L_MPI_SUFFIX)=%)

TGZ_PKGS            = $(CPP_PKG) $(FORTRAN_PKG) $(L_ITAC_P_PKG) $(L_MKL_PKG) $(L_MPI_PKG) $(L_TBB_PKG)
TAR_GZ_PKGS         = $(ADVISOR_PKG) $(INSPECTOR_PKG)
SOURCE_DIRS         = $(CPP_DIR) $(FORTRAN_DIR) $(ADVISOR_DIR) $(INSPECTOR_DIR) $(L_ITAC_P_DIR) $(L_MKL_DIR) $(L_MPI_DIR) $(L_TBB_DIR)

RPM.EXTRAS          = AutoReq:No
RPM.PREFIX          = $(PKGROOT)
