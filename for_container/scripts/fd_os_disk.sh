#! /bin/sh

local_dir=$(pwd)
libs_dir="${local_dir}/lib"
include_targets=''
if [ ! -d ${libs_dir} ]; then
    exit 1
fi
include_targets=$(ls -1 "${libs_dir}/"*.sh)
if [ -z "${include_targets}" ]; then
    exit 1
fi
for current_include in ${include_targets} ; do
    if [ -f ${current_include} ] ; then
        source ${current_include}
    fi
done

function main(){
    local return_code=0
    local fd_version="$1"
    local fd_ver_cond=$(echo ${fd_version} | sed 's/\.//g')
    local remote_sources="FD${fd_ver_cond}-LiveCD FD${fd_ver_cond}-BonusCD"
    local local_sources="FD${fd_ver_cond}LIVE FD${fd_ver_cond}BNS"
    local live_cd="FD${fd_ver_cond}LIVE"
    local root_dir=$(pwd | rev | sed 's/\([^\/]*\/\)\{1\}//' | rev)
    local config_dir="${root_dir}/config"
    local package_lists="fd_base_pkgs fd_extra_pkgs"

    #Get remote sources
    for current_source in ${remote_sources} ; do
        fd_source ${root_dir} ${fd_version} ${current_source}
    done

    #Extract packages from source
    for current_source in ${local_sources} ; do
        fd_package ${root_dir} ${current_source}
    done

    #Build the directory for our FD OS
    fd_build_sys ${root_dir} ${live_cd}

    #Install our packages for the OS disk
    for current_config in ${package_lists} ; do
        if [ -f "${config_dir}/${current_config}.txt" ] ; then
            for current_package in $(cat "${config_dir}/${current_config}.txt") ; do
                fd_install_pkg ${root_dir} ${current_package}
            done
        fi
    done

    return ${return_code}
}

main $@
