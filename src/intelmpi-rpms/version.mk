NAME               = sdsc-intelmpi
VERSION            = 2016.3.210
RELEASE            = 2
RPM.EXTRAS         = "Autoprov: 0"/nAutoReq:No/n%define  __prelink_undo_cmd %{nil}
PKGROOT            = /opt/intel/$(VERSION)

RPM.EXTRAS     = AutoReq:No \n %define         __prelink_undo_cmd     %{nil}
