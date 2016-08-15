SRCDIRS = `find * -prune\
	  -type d 	\
	  ! -name CVS	\
          -not -name intelmpi-rpms \
          -not -name build-\* \
	  ! -name .` intelmpi-rpms
