#! /bin/sh

function fd_package(){
    local return_code=0
    local root_dir="$1"
    local download_dir="${root_dir}/download"
    local package_dir="${root_dir}/packages"
    local mount_dir="${root_dir}/mount"
    local source_disk="${download_dir}/$2.iso"

    mkdir -p "${download_dir}"
    mkdir -p "${package_dir}"

    echo "SOURCE = ${source_disk}"
    if [ -f "${source_disk}" ]; then

        mkdir -p "${mount_dir}"
        7z x "${source_disk}" -o"${mount_dir}"
        echo "PACKAGES LIST:"
        ls -1 "${mount_dir}/packages"/*/*.zip
        cp -u ${mount_dir}/packages/*/*.zip "${package_dir}"
        rm -rf "${mount_dir}"

    fi

    return ${return_code}
}
export -f fd_package
