#! /bin/sh

function fd_source(){
    local return_code=0
    local version="$2"
    local source="$3"
    local root_dir="$1"
    local download_dir="${root_dir}/download"
    local target_url="https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/${version}/official/${source}.zip"
    local tmp_save="/tmp/$(dd if=/dev/urandom | tr -dc 'a-zA-Z0-9'  | dd bs=8 count=1 status=none).zip"

    #Get the remote file
    curl "${target_url}" -o "${tmp_save}"

    return_code=$?
    if [ ${return_code} -gt 0 ] ; then
        if [ -f "${tmp_save}" ]; then
            rm "${tmp_save}"
        fi
        return ${return_code}
    fi

    #We unzip the contents now to the downloads
    mkdir -p "${download_dir}"
    unzip -o "${tmp_save}" -x "*.txt" -d "${download_dir}"
    return_code=$!
    rm "${tmp_save}"
    return ${return_code}
}
export -f fd_source
