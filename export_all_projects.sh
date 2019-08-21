####EXPORT ALL PROJECTS ####
#Felipe G.  
#15 Abril 2019 
#Version : 1
###########################

#!/usr/bin/env bash 
set -ea

DRYRUN=false
export RD_COLOR=0
declare -a all_projects
declare -a jobs_to_disable
all_projects=( $(rd projects  list -% %name) )


for project_name in "${all_projects[@]-}"
do
        jobs_to_disable+=("$uid")
        printf "INFO: Exporting Project name: %s\n" "$project_name"
done

if [ ${#all_projects[*]} -lt 1 ]
then
    printf "INFO: Nothing to do. exiting\n"
    printf "INFO: Disabling %s jobs ...\n" "${#all_projects[*]-}"
    exit 0

fi

	for project_name in "${all_projects[@]-}"
	do
   	 if [[ "${DRYRUN:-}" == true ]]
    	then
       	 printf "DRYRUN: rd projects archives export -f %s.jar -p %s \n" "$project_name" "$project_name"
   	 else
       	    rd projects archives export -f "$project_name".jar -p "$project_name"
    	fi
	done
echo "INFO: Done."

exit $?
