#!/usr/bin/env bash

# Disable All scheduled jobs 
# Author: Felipe G. 
# Date:     15/Apr/2019
# Version:  2

#!/usr/bin/env bash 
set -ea

DRYRUN=false
export RD_COLOR=0
declare -a all_projects

all_projects=( $(rd projects  list -% %name) )

for project_name in "${all_projects[@]-}"
do
   	 if [[ "${DRYRUN:-}" == true ]]
    	 then
       	 	printf "DRYRUN: rd projects archives export -f %s.jar -p %s \n" "$project_name" "$project_name"
	 else
		rd projects configure get -p $project_name > $project_name.properties
		sed -i "s/project.disable.schedule: false/project.disable.schedule: true/g" "$project_name".properties
		rd projects configure set -p $project_name -f "$project_name".properties
		printf "INFO: Disabling scheduled for project %s\n" "$project_name"
		rm $project_name.properties
	fi
done
echo "INFO: Done."
exit $?
