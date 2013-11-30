#!/bin/sh
# Init some base variables
APPNAME=$(basename $0)

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