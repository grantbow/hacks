#
# cdocker         function for changing DOCKER_HOST environment variable
#                 to use, source this file from $HOME\.bash_profile then
#                 call/invoke 'cdocker' from your prompt
#
# Author:	Grant Bowman <grantbow@grantbow.com>
#
# Version:	
#           cdocker  0.1  2014-08-03  grantbow@grantbow.com
#           cdocker  0.2  2014-08-04  grantbow@grantbow.com - works but not a function yet
#           cdocker  0.3  2014-08-06  grantbow@grantbow.com - functions use variable space of shell
#                                                             that's why we are using a function to set a variable
#                                                             must clean up our variables, no assumptions
#                                                             "event" from comments is now value of DOCKER_HOST
#                                                             changed variable names to prevent conflicts
#                                                             prepended C because we are "changing" DOCKER_HOST
#                                                             if these vars are used in shell elsewhere they will be cleared
#
# Package Dependencies: iselect
#
# Config Spec:  each line in .cdocker.conf is used for one DOCKER_HOST value
#                       tcp://127.0.0.1:2375
#

function cdocker() {

CNAME="cdocker"
CDESC="changes the DOCKER_HOST value from .cdocker.conf and logs to .cdocker.log"

# depends on $HOME
CLOG=$HOME/.$CNAME.log
CCONFIGFILE=$HOME/.$CNAME.conf
CSECONDS=`date +%s`            # current
#PIDFILE=/var/run/$CNAME.pid   # not used yet

########### * assumes * existence of tail, cut, dc, date
if ! [[ -x `which iselect` ]] ; then {
    echo "Please install iselect.";
}
fi

# no --help yet

# hot keys easy to implement outside the script with numeric or event name parameter

if ! [ -e $CLOG ]; then { # missing log
    touch $CLOG ;
    echo -e "DOCKER_HOST\tepoch_seconds\thour_of_day\tinterval_hours\treadable_date" >> $CLOG
    CLASTSECONDS=$CSECONDS
    CLASTEVENT="NONE"
    CLASTDATE="NEVER" # only used for display of iselect
    #CLASTDATE=`date -d "1970-01-01 UTC $CLASTSECONDS seconds" `
    }
else {                   # log exists, read last event
    CLASTSECONDS=`tail -1 $CLOG | cut -f 2`
    CLASTEVENT=`tail -1 $CLOG | cut -f 1`
    if [[ $CLASTSECONDS == "epoch_seconds" ]]; then { # no data in the log yet
        CLASTSECONDS=$CSECONDS
        CLASTEVENT="NONE"
        CLASTDATE="NEVER"
        }
    else { # assume log not empty, CLASTSECONDS and CLASTEVENT are ok
        CLASTDATE=`date -d "1970-01-01 UTC $CLASTSECONDS seconds" `
        }
    fi
    }
fi



# Read a config file if it is present.
if [ -r $CCONFIGFILE ] ; then {
    readarray -t CCYCLE < $CCONFIGFILE # a bash builtin, CCYCLE is an indexed array
    }
else {
    # elegant way to declare CCYCLE and write the file
    CCYCLE=("tcp://127.0.0.1:2375" "")
    printf '%s\n' ${CCYCLE[*]} >> $CCONFIGFILE
    printf '\n' >> $CCONFIGFILE
    }
fi

# check CCYCLE values for blank lines
# change loop is omitted indexes won't cause problems
# for each?
CY=${#CCYCLE[*]}
for (( CX=0 ; $CX < $CY ; CX++ )) ; do {
    #echo "cx is $CX val is ${CCYCLE[CX]}" # debug
    if [ -z "${CCYCLE[CX]}" ] ; then {
        CCYCLE[CX]=BLANK
        }
    fi
    }
done

unset CMENURETURN CMENUCONTENT CSELECTINDEX
CINITSELECTION="1" # pre-highlight item, default is first item
CY=${#CCYCLE[*]} # set because there's trouble evaluating directly in the for (())
# when change loop is omitted indexes won't cause problems # for each?
for (( CX=0 ; $CX < $CY ; CX++ )) ; do {

    CC=${CCYCLE[CX]} # current event name
    # construct menu content for iselect
    CZ=$(($CX+1)) # +1 convert from zero index
    CMENUCONTENT="$CMENUCONTENT<s:$CZ>$CZ.$CC "; # if " " instead of "." 2 params

    #echo "${CCYCLE[CX]}" # debug
    #echo "$CLASTEVENT" # debug

    if [[ $CLASTEVENT = ${CCYCLE[CX]} ]] ; then { # highlight the next event
        CINITSELECTION=$(( $CZ + 1 )) # +1 next value
        }
    fi

    if [[ $1 == $CC || $1 == $CZ ]] ; then { # check for numeric or named event
        CMENURETURN="$CZ" # valid parameter passed to script, no need for menu now
        }
    fi
    }
done

# if CINITSELECTION is too high, highlight first event
if [[ $CINITSELECTION -gt $CY ]] ; then {
    CINITSELECTION="1"
    }
fi

# present menu with configuration & previous event
#echo "cinitselection $CINITSELECTION" #debug
#echo "cmenucontent $CMENUCONTENT" #debug
#echo "cmenureturn $CMENURETURN" #debug
#sleep 10
CZ=$(( ${#CCYCLE[*]} + 1 )) # zero to one based, configuration menu item
CT=$(( $CZ + 1 ))
if [[ ! $CMENURETURN ]] ; then {
    CMENURETURN="`iselect $CMENUCONTENT \"\" \"<s:$CZ>$(($CZ)).configuration\" \"<s:$CT>$(($CT)).cancel\" \"\" \"Previous event - $CLASTEVENT $CLASTDATE\" \"\" \"This menu $CDESC\" -p $CINITSELECTION -n \"\" -kj:KEY_DOWN -kk:KEY_UP -kl:KEY_RIGHT -kSPACE:RETURN -t \"$CNAME testing version\"`"
    # couldn't get ESC to map to q or KEY_LEFT - quite annoying
    }
fi

# write a message to STDOUT after each run
#echo -e "\tCheck out http://docker.com"
#echo -e "\t$CMENURETURN" #DEBUG

CSELECTINDEX=$(($CMENURETURN-1)) # back to 0 based array
CZ=$(( $CZ - 1 )) # back to 0 based

if [[ $CSELECTINDEX == $(($CZ)) ]] ; then {            # configuration selected
    echo -e "\nValues are in:       $CCONFIGFILE (exists)\n"
    echo -e "       Logged:       $CLOG (exists)\n"
    echo -e

    }
elif [[ $CSELECTINDEX -le ${#CCYCLE} ]] ; then {
    # log the event
    CMYHOUR=`date +%k`
    CXMIN=`date +%M`
    CMYMIN=`dc -e " 2 k $CXMIN 60 / n "`
    CNEWDOCKERHOST="${CCYCLE[CSELECTINDEX]}"
    if [[ $CMYMIN == 0 ]] ; then
        CMYMIN=".0" # correction for possible dc output
    fi
    if [[ $CLASTSECONDS == $CSECONDS ]] ; then
        echo -e "$CNEWDOCKERHOST\t$CSECONDS\t$CMYHOUR$CMYMIN\t0.0\t`date`" >> $CLOG
    else
        echo -e "$CNEWDOCKERHOST\t$CSECONDS\t$CMYHOUR$CMYMIN\t`dc -e \" 2 k $CSECONDS $CLASTSECONDS - 3600 / n\"`\t`date`" >> $CLOG
    fi
    
    echo -e "previous DOCKER_HOST $DOCKER_HOST"
    echo -e "     new DOCKER_HOST $CNEWDOCKERHOST"
    if [[ $CNEWDOCKERHOST == "BLANK" ]] ; then
        export DOCKER_HOST=""
    else
        export DOCKER_HOST="$CNEWDOCKERHOST"
    fi

        # use dc to give the difference between two second values (replace variables):
        #
        # 	dc -e " 2 k $SECONDS $CLASTSECONDS - 3600 / n"
        #
        # use this to give the seconds of any --date (replace string):
        #
        # 	date --date="Jun 28 19:38:15 PDT 2003" +%s
        #
        # use this to convert epoch seconds back using local time zone (replace 946684800):
        #
        # 	date -d '1970-01-01 UTC 946684800 seconds' +"%Y-%m-%d T %T%z"
        #
        # use this to create an hour of day value
        #
        #       dc -e " 2 k `date +\"%M\"` 60 / n "
        #
    }
else { # iselect shouldn't allow this
    echo -e "Nothing recorded to .$CNAME.log."
    }
fi

##### conclude
unset CNAME CDESC CLOG CCONFIGFILE CSECONDS CLASTSECONDS CLASTEVENT CLASTDATE CCYCLE CMENUCONTENT CINITSELECTION CX CY CMENURETURN CSELECTINDEX CZ CT CMYHOUR CXMIN CMYMIN CNEWDOCKERHOST

}

