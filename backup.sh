
 # --Functions

<<commentname 
log() {
    
    local VERBOSE="${1}"
    shift 
    local msg="${@}"
    if [[ ${VERBOSITY} = "true" ]];then
	 echo "${msg}"
    fi
}

VERBOSITY="true"
log ${VERBOSITY} 'Hello! This is fun..'
log ${VERBOSITY} "First time learning functions in Shell Script"

commentname


log() {

   # This function sends a message to syslog and to standard output if VERBOSE is trUe.
   local msg="${@}"
   if [[ ${VERBOSE} = "true" ]]; then
      echo "${msg}"
   fi 

   logger -t luser-demo10.sh "${msg}"
}


backup_file() {
   # This function creates a backup of a file. Returns non-zero status on error.

   local FILE="${1}"

   # Make sure the file exists.
   if [[ -f "${FILE}" ]]
   then 
       local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N+)"
       log "Bakcing up ${FILE} to ${BACKUP_FILE}"

       # The exit status of the function will be the exit status of the cp command.
       cp -p ${FILE} ${BACKUP_FILE}
   else
       # the file doen't exist, so return a non-zero exit status.
       return 1
   fi
}


readonly VERBOSE="true"
log "Hello!"
log "This is fun!"

backup_file "/etc/passwd"


# Make a decision based on the exit status of the function.
if [[ "${?}" -eq 0 ]]
then
   log 'File backup succeeded!'
else
   log 'File backup failed!'
   exit 1
fi 



