#!/bin/bash
set -eu

# Usage:
# ./Restart.sh <ProjectNumberOrName> <SLURM_JOB_NAME> <SLURM_JOB_ID> <YOUREMAIL>
#
# Get command line arguments
ProjectNumberOrName=$1
JobName=$2
JobID=$3
EMAIL=$4
Machine=$4

# Get node number as well
ThisMachine=$Machine"_"$(hostname -s)

# From https://stackoverflow.com/questions/60082303/how-to-configure-slurm-to-email-out-file
secs_to_human(){
    echo "$(( ${1} / 3600 )):$(( (${1} / 60) % 60 )):$(( ${1} % 60 ))"
}
start=$(date +%s)
echo "$(date -d @${start} "+%Y-%m-%d %H:%M:%S"): ${JobName} start id=${JobID}\n"

LOGFILE=".bfi_restart/"$ProjectNumberOrName".log"

CommonSubject="after $(secs_to_human $(($(date +%s) - ${start}))), on machine=$ThisMachine id=$JobID"

# Run RestartProject and send email with summary
( RestartProject -r $ProjectNumberOrName) \
    && (tail -n 6 $LOGFILE |  mail -s "RestartProject -r $ProjectNumberOrName ended $CommonSubject" $EMAIL && echo Mail sent) \
    || (tail -n 6 $LOGFILE |  mail -s "RestartProject -r $ProjectNumberOrName Failed $CommonSubject" $EMAIL && echo Mail sent && exit $?)
