#! /bin/bash

RECUR= false
TIMEOUT=48
NEWNAME="fc-"

while getopts ":rt:" opt;do
  case ${opt} in 
   r) #recursive mode
        echo "recursive mode"
        RECUR=true
        recursive
        ;;
   t) #change time 
        TIMEOUT=$OPTARG
        echo "time is ${TIMEOUT}h"
        ;;

   \?)echo "invalid - $OPTARG" 
        usage
        ;;

    help | *) 
        usage
        ;;

  esac
done


File_name="$@"  #file added in the terminal

#delete old file  --- with fc-*
find . -name "${NEWNAME}*" -type f  -mmin +{$TIMEOUT * 60 } -delete


#touch new compressed  file + add fc- to file name 
for FILE in 'find . -f'
do 
    ##ADD CHECK NOT START WITH FC-
    if ( $FILE | grep -q compressed ); then 
      mv "${NEWNAME}${FILE}"   
      touch  "${NEWNAME}${FILE}"
      else 
        zip $FILE  "${NEWNAME}${FILE}"  # compress uncompressed file
    fi
done


function recursive(FILE) {
 
 for DIRECTORY in 'find . -d' 
 do
    if ($1); then 
        zip -D -r $1 "${NEWNAME}${1}"
        return 
    fi

    if ($RECUR); then
        zip -r $DIRECTORY  "${NEWNAME}${1}"
    else 
        #over all non-folder - non recrusive
        DIRNAME="find . -d"
        zip -D $DIRNAME "${NEWNAME}*.*"
    fi
 done
}


# take care of arguments
if [[ -f $File_name ]]; then 
    for FILE in $File_name
    do
    zip FILE -m "${NEWNAME}${FILE}"
    if [[ $RECUR ]]; then 
        recursive($FILE)
    fi
fi
# if arguments is a folder 
if [[ -d $File_name ]]; then 
    for FILE in $File_name
    do 
    recursive($FILE)
fi









