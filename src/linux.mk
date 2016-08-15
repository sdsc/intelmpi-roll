SRCDIRS = `find * -prune\
	  -type d 	\
	  ! -name CVS	\
          -not -name intempi-rpms \
          -not -name build-\* \
	  ! -name .` intelmpi-rpms
