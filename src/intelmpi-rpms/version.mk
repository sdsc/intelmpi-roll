NAME               = sdsc-intelmpi
VERSION            = 2018.1.163
RELEASE            = 0
RPM.EXTRAS         = "Autoprov: 0"/nAutoReq:No/n%define  __prelink_undo_cmd %{nil}
PKGROOT            = /opt/intel/$(VERSION)

RPM.EXTRAS         = AutoReq:No \n %define         __prelink_undo_cmd     %{nil}
RPM.PREFIX         = $(PKGROOT)
