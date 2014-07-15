#!/bin/bash
NAME=$(hostname)
CURRENT=$(dirname $0)
INIT_SCRIPT="${CURRENT}/init_${NAME}.sh"

if [ -f "${INIT_SCRIPT}" ]; then
	${INIT_SCRIPT}
else
	echo "warning: ${INIT_SCRIPT} does not exist."
fi
