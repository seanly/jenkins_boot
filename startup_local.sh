#! /bin/bash -e

JENKINS_VERSION=2.89.2
JENKINS_URL=https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/$JENKINS_VERSION/jenkins.war
CURDIR=`dirname $0`
JENKINS_PORT=3722

if [ ! -f $CURDIR/jenkins.war ]; then
  curl -o $CURDIR/jenkins.war $JENKINS_URL
fi

: "${JENKINS_HOME:="$CURDIR/userData"}"

extra_java_opts=( \
  '-Djenkins.install.runSetupWizard=false -Djenkins.model.Jenkins.slaveAgentPort=50000' \
  '-Djenkins.model.Jenkins.slaveAgentPortEnforce=true' \
  "-Dio.jenkins.dev.security.createAdmin=true" \
  "-Dio.jenkins.dev.security.allowRunsOnMaster=true" \
  '-Dhudson.model.LoadStatistics.clock=1000' \
  '-Dhudson.model.ParametersAction.keepUndefinedParameters=true' \
)

export JAVA_OPTS="$JAVA_OPTS ${extra_java_opts[@]}"

# read JAVA_OPTS and JENKINS_OPTS into arrays to avoid need for eval (and associated vulnerabilities)
java_opts_array=()
while IFS= read -r -d '' item; do
  java_opts_array+=( "$item" )
done < <([[ $JAVA_OPTS ]] && xargs printf '%s\0' <<<"$JAVA_OPTS")

jenkins_opts_array=( \
  "--httpPort=${JENKINS_PORT}" \
  )
while IFS= read -r -d '' item; do
  jenkins_opts_array+=( "$item" )
done < <([[ $JENKINS_OPTS ]] && xargs printf '%s\0' <<<"$JENKINS_OPTS")

exec java -Duser.home="$JENKINS_HOME" "${java_opts_array[@]}" -jar $CURDIR/jenkins.war "${jenkins_opts_array[@]}" "$@"
