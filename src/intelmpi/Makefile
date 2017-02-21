#
# $Id$
#
# @Copyrighl@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		       version 6.1.1 (Sand Boa)
# 
# Copyright (c) 2000 - 2014 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

$(NAME).spec: DESCRIPTION LICENSE

RPMS = 20
RPM_TO_BUILD = 1
TEMP_DIRS = $(REDHAT.ROOT)/src

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC) \
	) > $@

LICENSE: $(SRC_DIRS)
	$(CHECK_LICENSE_FILES)
	echo intel > $@

build: $(SRC_DIRS)
        if test "$(RPM_TO_BUILD)" = "1"; then \
            patch $(SOURCE_DIR)/silent.cfg patch-files/silent.cfg.patch; \
            perl -pi -e "s!PKGROOT!$(PKGROOT)!g" $(SOURCE_DIR)/silent.cfg; \
            mkdir $(PKGROOT); \
            if test -z $(LICENSESERVER); then \
              echo  "Licenseserver address needed: e.g. ROLLOPTS=23000\\@license.edu"; \
              exit -1; \
            fi; \
            perl -pi -e "s!LICENSEPATH!$(LICENSESERVER)!g" $(SOURCE_DIR)/silent.cfg; \
           cd $(SOURCE_DIR); \
           ./install.sh --silent silent.cfg; \
           ls rpm/*.rpm > $(REDHAT.ROOT)/rpmnames; \
        fi
        )
	@echo "::: Package $(NAME) build complete :::"

install::
	mkdir  -p -m 755 $(ROOT)/$(PKGROOT)
	( \
          cd $(PKGROOT); \
          find . -type f | sort | perl -e 'for(my $$i=0;<>;$$i++){chomp and `/bin/cp --parents "$$_" $(ROOT)/$(PKGROOT)/` if $$i%$(RPMS)+1 == $(RPM_TO_BUILD);}'; \
        )
	if test "$(RPM_TO_BUILD)" = "1"; then \
          for rpm in `seq 2 $(RPMS)`; do \
            echo $(MAKE) NAME=$(NAME)_$$rpm RPM_TO_BUILD=$$rpm rpm; \
            $(MAKE) NAME=$(NAME)_$$rpm RPM_TO_BUILD=$$rpm rpm; \
          done; \
          $(INSTALL_LICENSE_FILES); \
        fi
        @echo "::: Package $(NAME) install complete :::"


clean::
	rm -rf $(SOURCE_DIR) $(TEMP_DIRS)/*.tmp DESCRIPTION LICENSE $(PKGROOT)
