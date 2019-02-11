# make sure the script which includes this file runs only once simultaneously

PID_DIR=/tmp
PID_FILE="`basename $0`.pid"
PID_FILE_WRITTEN=

remove_pid_file_and_exit()
{
  # remove the pid file, if it has been written
  if [ -n "$PID_FILE_WRITTEN" ]
  then
    rm -f $PID_DIR/$PID_FILE
  fi
  exit
}

trap remove_pid_file_and_exit EXIT HUP INT QUIT ABRT KILL ALRM TERM

is_unique()
{
  if [ -z $PID_FILE ]; then echo "\$PID_FILE not set " >&2; exit 1; fi
  if [ -e $PID_DIR/$PID_FILE ]
  then
    # XXX: system specific stuff ahead
    PID_DATE=`ls -l --time-style=+%d $PID_DIR/$PID_FILE | awk '{ print $6; }' |\
              sed s/^0//`
    NOW_DATE=`date +%d | sed s/^0//`
    PID_DATE_YESTERDAY=`expr 1 + $PID_DATE`
    if [ "$PID_DATE" != "$NOW_DATE" ] &&
       [ "$PID_DATE_YESTERDAY" != "$NOW_DATE" ]
    then
      echo "$PID_DIR/$PID_FILE not from today or yesterday" >&2
      exit 1
    fi
    return 1 # not unique
  fi
  echo $$ > $PID_DIR/$PID_FILE # write pid file
  PID_FILE_WRITTEN="yes"
  return 0 # is unique
}
