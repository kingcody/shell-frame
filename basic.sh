#!/bin/sh
# Init some base variables
APPNAME=$(basename $0)

# Color Vars
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
bakblk='\e[40m' # Black - Background
bakred='\e[41m' # Red
bakgrn='\e[42m' # Green
bakylw='\e[43m' # Yellow
bakblu='\e[44m' # Blue
bakpur='\e[45m' # Purple
bakcyn='\e[46m' # Cyan
bakwht='\e[47m' # White
txtrst='\e[0m' # Text Reset

# Init some base functions
function usage {

  # Display usage message on standard error
  echo "Usage: $APPNAME file" 1>&2
}

function clean_up {

  # Perform program exit housekeeping
  # Optionally accepts an exit status
  
  exit $1
}

function clean_exit {

  # Wrapper for clean_up 0

  
}

function error_exit {

  # Display error message and exit
  echo "${APPNAME}: ${1:-"Unknown Error"}" 1>&2
  clean_up 1
}


# Reset all variables that might be set
file=""
verbose=0

while :
do
    case $1 in
        -h | --help | -\?)
            usage
            clean_up 0          # This is not an error, User asked help. We clean_up with exit 0
            ;;
        -f | --file)
            file=$2             # You might want to check if you really got FILE
            shift 2
            ;;
        --file=*)
            file=${1#*=}        # Delete everything up till "="
            shift
            ;;
        -v | --verbose)
            # Each instance of -v adds 1 to verbosity
            verbose=$((verbose+1))
            shift
            ;;
        --) # End of all options
            shift
            break
            ;;
        -*)
            echo "WARN: Unknown option (ignored): $1" >&2
            shift
            ;;
        *)  # no more options. Stop while loop
            break
            ;;
    esac
done

# Suppose some options are required. Check that we got them.

if [ ! "$file" ]; then
    error_exit "ERROR: option '--file FILE' not given. See --help" >&2
fi

# Rest of the program here.
# If there are input files (for example) that follow the options, they
# will remain in the "$@" positional paramete