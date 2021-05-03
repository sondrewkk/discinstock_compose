#!/bin/bash
set -e;

# a default non-root role
MONGO_NON_ROOT_ROLE="${MONGO_NON_ROOT_ROLE:-readWrite}"
MONGO_NON_ROOT_PASSWORD=$(cat $MONGO_NON_ROOT_PASSWORD_FILE)

if [ -n "${MONGO_NON_ROOT_USERNAME:-}" ] && [ -n "${MONGO_NON_ROOT_PASSWORD:-}" ]; then
	"${mongo[@]}" "$MONGO_INITDB_DATABASE" <<-EOJS
		db.createUser({
			user: $(_js_escape "$MONGO_NON_ROOT_USERNAME"),
			pwd: $(_js_escape "$MONGO_NON_ROOT_PASSWORD"),
			roles: [ { role: $(_js_escape "$MONGO_NON_ROOT_ROLE"), db: $(_js_escape "$MONGO_INITDB_DATABASE") } ]
			})
	EOJS
else
	echo "init_db.sh FAILED"
fi