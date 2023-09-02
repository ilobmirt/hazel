#! /bin/sh

function fd_build_sys(){
    local return_code=0
    local root_dir="$1"
    local download_dir="${root_dir}/download"
    local live_image="${download_dir}/$2.iso"
    local build_dir="${root_dir}/build_target"
    local mount_dir="${root_dir}/mount"

    mkdir -p ${build_dir}
    mkdir -p ${mount_dir}

    if [ ! -f "${live_image}" ];then
        rm -rf ${mount_dir}
        return 1
    fi

    #"MOUNT" the livecd ... but not really
    7z x "${live_image}" -o${mount_dir}

    #CDROM and drivers
    mkdir -p ${build_dir}/FREEDOS/APPINFO
    mkdir -p ${build_dir}/FREEDOS/BIN
    cp -u ${mount_dir}/freedos/appinfo/cdrcache.* ${build_dir}/FREEDOS/APPINFO
    cp -u ${mount_dir}/freedos/bin/*.sys ${build_dir}/FREEDOS/BIN

    #Copy base apps
    local copy_targets='fdimples.exe fdinst.exe fdnpkg.cfg command.com'
    for current_file in ${copy_targets} ; do
        cp -u "${mount_dir}/freedos/bin/${current_file}" "${build_dir}/FREEDOS/BIN"
    done

    #Copy the configuration
    cp -u ${mount_dir}/FDOS-x86/FREEDOS/CONFIGS/CONFIG.DEF ${build_dir}/FDCONFIG.SYS
    sed 's/\$FDRIVE\$/C:/g;s/\$FTARGET\$/C:\\Freedos/g;s/\$FCCC\$/001/g;s/\$FCKC\$/858/g;s/\(\$.*\$\)/rem\ \1/g' ${build_dir}/FDCONFIG.SYS -i

    cp -u ${mount_dir}/FDOS-x86/FREEDOS/CONFIGS/AUTOEXEC.DEF ${build_dir}/FDAUTO.BAT
    sed 's/\$FDRIVE\$/C:/g;s/\$FTARGET\$/C:\\Freedos/g;s/\$FLANG\$/EN/g;s/\$TZ\$/UTC/g;s/\(\$.*\$\)/rem\ \1/g' ${build_dir}/FDAUTO.BAT -i

    rm -rf ${mount_dir}

    return ${return_code}
}
export -f fd_build_sys
