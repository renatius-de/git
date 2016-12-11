#!/bin/bash

GIT_DIR="${GIT_DIR:-${PWD}/.git}"
source "${GIT_DIR}"/hooks/config.sh
source "${HOOKS_DIR}"/base/change_detector.sh

build_base()
{
    "${HOOKS_DIR}"/base/ctags "${1}" &
    "${HOOKS_DIR}"/base/cscope "${1}" &
}

build_php()
{
    COMPOSER_JSON="${PROJECT_DIR}"/composer.json
    if [ -e "${COMPOSER_JSON}" ] && has_changed ${1} "${COMPOSER_JSON}"; then
        "${HOOKS_DIR}"/php/composer.sh
    fi

    build_base php
}

if which php > /dev/null 2>&1; then
    build_php
fi