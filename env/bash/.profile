__ENV_DEBUG=true
__ENV_TRACE_FILE=~/env_debug.log

. ~/top/stdenv/env_helpers.sh

_env_trace ${BASH_SOURCE[0]} "Starting..."

_env_trace ${BASH_SOURCE[0]} "Start sourcing ~/.orig/.profile..."
. ~/.orig/.profile
_env_trace ${BASH_SOURCE[0]} "...End sourcing ~/.orig/.profile"

. ~/top/stdenv/env/my_profile.sh

_env_trace ${BASH_SOURCE[0]} "...Ending"
