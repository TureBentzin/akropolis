set -euo pipefail

ls -lsah $SRC

export GRADLE_USER_HOME="$TMPDIR/gradle"
gradle shadowJar