#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


# shell version
# ====================
SHELL_VERSION="2.8.2"
# ====================


# current path
CUR_DIR=$( pwd )


# base url
methods="Online"
BASE_URL="https://github.com/loyess/Shell/raw/master"
if [ -e install ] && [ -e prepare ] && [ -e service ] && [ -e templates ] && [ -e utils ] && [ -e webServer ]; then
    methods="Local"
    BASE_URL="${CUR_DIR}" 
fi

status_menu(){

    status_init

    if [ -e "${ssPath}" ] && [ -e "${pluginPath}" ] && [ -e "${webPath}" ]; then
        if [ -n "${ssPid}" ] && [ -n "${pluginPid}" ] && [ -n "${webPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [ -e "${ssPath}" ] && [ -e "${pluginPath}" ]; then
        if [ -n "${ssPid}" ] && [ -n "${pluginPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [ -e "${ssPath}" ]; then
        if [ -n "${ssPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    else
        echo -e "${NoInstall}"
    fi
}


improt_package(){
    local package=$1
    local sh_file=$2
    
    if [ ! "$(command -v curl)" ]; then
        package_install "curl" > /dev/null 2>&1
    fi
    
    if [ "${methods}" = "Online" ]; then
        source <(curl -sL "${BASE_URL}/${package}/${sh_file}")
    else
        cd "${CUR_DIR}"
        source "${BASE_URL}/${package}/${sh_file}"
    fi
}
