NAME               = sdsc-intelmpi
VERSION            = 2018.1.163
RELEASE            = 2
RPM.EXTRAS         = "Autoprov: 0"/nAutoReq:No/n%define  __prelink_undo_cmd %{nil}
PKGROOT            = /opt/intel/$(VERSION)

RPM.EXTRAS         = AutoReq:No \n %define         __prelink_undo_cmd     %{nil}\n%define __os_install_post /usr/lib/rpm/brp-python-bytecompile
RPM.PREFIX         = $(PKGROOT)
