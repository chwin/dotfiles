#!/usr/bin/env bash

set -e
set -x

REGEX='^([_0-9a-zA-Z\-]+)\.([_0-9a-zA-Z\-]+)'

if [[ -z "$1" ]]; then
    list_file=`realpath "extensions.txt"`
else
    list_file=`realpath "$1"`
fi
if [ -f $list_file ]; then
    echo "File $list_file exists."
else
    echo "File $list_file does not exist."
    return
fi

exts=`code --list-extensions`

while read extension_line; do
    echo "$extension_line"
    if [[ $extension_line =~ $REGEX ]]
    then
        if [[ "$exts" =~ $extension_line ]]
        then
            echo  "Extension $extension_line is already installed."
        else
            echo "Installing $extension_line"
            code --install-extension "$extension_line"
        fi
    else
        echo "Something wrong!"
    fi
done < $list_file