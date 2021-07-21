#!/bin/bash

if [ "$CIRCLE_BRANCH" = "" ]; then
    # It appears that CircleCI doesn't set CIRCLE_BRANCH for tagged builds.
    # Assume we're doing them on the master branch, I guess.
    BRANCH=master
else
    BRANCH=$CIRCLE_BRANCH
fi

echo "Deploying website updates for $BRANCH branch"

if [ -z "${GIT_EMAIL}" -o -z "{$GIT_USER}" ]; then
    echo "No identity configured with GIT_USER/GIT_EMAIL"
    exit
fi

if [ -z "${GIT_PUB_REPO}" ]; then
    echo "No publication repository configured with GIT_PUB_REPO"
    exit
fi

if [ -z "${GIT_GRAMMAR_REPO}" ]; then
    echo "No grammar repository configured with GIT_GRAMMAR_REPO"
    exit
fi

if [ -z "${GH_TOKEN}" ]; then
    echo "No github token configured with GH_TOKEN for publication"
    exit
fi

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER

# N.B. This publish script actually updates the grammar repository
# and the gh-pages branch of the 3.0-specification repository!

pwd
