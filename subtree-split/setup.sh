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
subdir=${repo_subdir}
mkdir ${repo_dev}
cd ${repo_dev}
git init

msg="1st ${repo_dev}: root and subdir commit"
echo "$msg" >> ${repo_dev}.h
mkdir ${subdir}
echo "$msg" >> ${subdir}/${subdir}.h
git add .
git commit -m "${msg}"
msg="2nd ${repo_dev} : ${subdir} commit"
echo "$msg" >> ${subdir}/${subdir}.h
git add .
git commit -m "$msg"
cd ..
pwd

[[ ${replay:-} == true ]] || exit 0

set -x

echo "Press any key to next step"
[[ ${autocontinue:-} == true ]] || read -r cont
cd $repo_dev
git remote add component ../component/.git
../../../../git/contrib/subtree/git-subtree.sh split --prefix ${subdir} --branch ${subdir}/master

exit 0
git branch -a

echo "Press any key to next step"
[[ ${autocontinue:-} == true ]] || read -r cont

msg="3rd ${repo_dev} : root commit"
echo "${msg}" >> ${repo_dev}.h
git add ${repo_dev}.h
git commit -m "${msg}"

git checkout -b feature
git reset --hard HEAD~1

msg="4th ${repo_dev} : ${subdir} commit on branch"
echo "${msg}" >> ${subdir}/${subdir}.h
git add ${subdir}/${subdir}.h
git commit -m "${msg}"

git checkout master
git subtree split --prefix ${subdir} --branch ${subdir}/master --onto ${subdir}/master

msg="5th ${repo_dev}: root and subdir commit"
echo "$msg" >> ${repo_dev}.h
touch ${subdir}/${subdir}.c && echo "$msg" >> ${subdir}/${subdir}.c
git add .
git commit -m "${msg}"

git merge feature

git checkout feature
msg="6th ${repo_dev}: root commit"
touch ${repo_dev}.c && echo "$msg" >> ${repo_dev}.c
git add .
git commit -m "${msg}"

git checkout master
git merge feature
git subtree split --prefix ${subdir} --branch ${subdir}/master --onto ${subdir}/master

msg="7th ${repo_dev}: root and subdir commit"
echo "$msg" >> ${repo_dev}.h
echo "$msg" >> ${subdir}/${subdir}.c
git add .
git commit -m "${msg}"

git subtree split --prefix ${subdir} --branch ${subdir}/master --onto ${subdir}/master

git branch -a

git push component ${subdir}/master:master

git log --graph --oneline --decorate --all
cd ../${repo_subdir}
git log --graph --oneline --decorate --all
cd ..
