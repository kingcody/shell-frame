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
  echo -e "${bldwht}$APPNAME - A basic shell template${txtrst}"
  echo -e "${bldgrn}Usage${bldwht}: $APPNAME --file=FILE${txtrst}"
  echo -e "${bldylw}Mandatory${bldwht}:${txtrst}"
  echo -e "${bldwht}-f, --file=FILE           do things to FILE${txtrst}"
  echo -e "${bldwht}Options:${txtrst}"
  echo -e "${bldwht}-v                        increase verbosity${txtrst}"
  # echo -e "${bldwht}${txtrst}" 1>&2
}

function clean_up {

  # Perform program exit housekeeping
  # Optionally accepts an exit status
  
  exit $1
}

function clean_exit {

  # Wrapper for clean_up 0
  clean_up 0
}

function error_exit {

  # Display error message and exit
  echo -e "${bldwht}${APPNAME}:${txtrst} ${1:-"Unknown Error"}" 1>&2
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
            clean_exit          # This is not an error, User asked help. We clean_exit
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
            echo -e "${bldylw}WARN${bldwht}: Unknown option (ignored): ${bldred}$1${txtrst}" >&2
            shift
            ;;
        *)  # no more options. Stop while loop
            break
            ;;
    esac
done

# Suppose some options are required. Check that we got them.

[[ ! "$file" ]] && error_exit "${bldred}ERROR${bldwht}: option '${bldylw}--file FILE${bldwht}' not given. See ${bldylw}--help${txtrst}"

# Rest of the program here.
# If there are input files (for example) that follow the options, they
# will remain in the "$@" positional paramete
clean_exit