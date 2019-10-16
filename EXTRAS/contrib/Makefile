#
# Netdisco MIBs Makefile
#
#

MIBS    = $(shell grep ^Version mibs/README | sed -n -e 's/^Version //;P')

all:
	@echo "Options are : mib-dist,mib-snapshot"

mib-dist:
	mv mibs netdisco-mibs-${MIBS}
	find netdisco-mibs-${MIBS} -name .git > excluded_files
	find netdisco-mibs-${MIBS} -name .index >> excluded_files
	tar -X excluded_files -c -v -z -f netdisco-mibs-${MIBS}.tar.gz netdisco-mibs-${MIBS}
	mv netdisco-mibs-${MIBS} mibs

mib-snapshot:
	mv mibs netdisco-mibs
	find netdisco-mibs -name .git > excluded_files
	find netdisco-mibs -name .index >> excluded_files
	tar -X excluded_files -c -v -z -f netdisco-mibs-snapshot.tar.gz netdisco-mibs
	mv netdisco-mibs mibs

.PHONY:all

.SILENT:
