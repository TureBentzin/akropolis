set -euo pipefail

export GRADLE_USER_HOME="$TMPDIR/gradle"
gradle shadowJar
