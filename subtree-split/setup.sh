#!/usr/bin/env bash

set -ue

[[ ${debug:-} == true ]] && set -x

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo ${SCRIPT_PATH}

EXERCISE_DIR=${SCRIPT_PATH}/exercise

###
#
# Basic setup
#
###
if [[ -d ${EXERCISE_DIR} ]]; then
  rm -rf ${EXERCISE_DIR}
fi


mkdir ${EXERCISE_DIR}

cd ${EXERCISE_DIR}

repo_subdir=component
mkdir ${repo_subdir}
cd ${repo_subdir}
git init --bare
cd ..

repo_dev=dev_env
mkdir ${repo_dev}
cd ${repo_dev}
git init
msg="1st ${repo_dev}: root commit"
echo "$msg" >> ${repo_dev}.h
git add ${repo_dev}.h
git commit -m "${msg}"
subdir=${repo_subdir}
mkdir ${subdir}
msg="2nd ${repo_dev} : ${subdir} commit"
echo "$msg" >> ${subdir}/${subdir}.h
git add ${subdir}/${subdir}.h
git commit -m "$msg"
cd ..
pwd

[[ ${replay:-} == true ]] || exit 0

set -x

echo "Press any key to next step"
#read -r cont
cd $repo_dev
git subtree split --prefix ${subdir} --branch ${subdir}/master

git branch -a

echo "Press any key to next step"
#read -r cont

msg="3rd ${repo_dev} : root commit"
echo "${msg}" >> ${repo_dev}.h
git add ${repo_dev}.h
git commit -m "${msg}"

msg="4th ${repo_dev} : ${subdir} commit"
echo "${msg}" >> ${subdir}/${subdir}.h
git add ${subdir}/${subdir}.h
git commit -m "${msg}"

git subtree split --prefix ${subdir} --branch ${subdir}/master --onto ${subdir}/master

git branch -a

git push ../${repo_subdir}  ${subdir}/master:master

