#! /bin/sh

function fd_install_pkg(){
    local return_code=0
    local root_dir="$1"
    local package="$2"
    local package_dir="${root_dir}/packages"
    local build_dir="${root_dir}/build_target"
    local install_dir="${build_dir}/FREEDOS"

    mkdir -p ${install_dir}

    if [ -f "${package_dir}/${package}.zip" ] ; then
        unzip "${package_dir}/${package}.zip" -x "SOURCE/*" -d ${install_dir}
    else
        return_code=1
    fi

    return ${return_code}
}
export -f fd_install_pkg
