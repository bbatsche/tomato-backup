#!/bin/sh

ScriptInfo_archive_opt() {
    SCRIPT_NAME="Tomato Router Archive Opt"; SCRIPT_VERSION="1.0"; SCRIPT_DATE="2020-03-02"; SCRIPT_AUTHER="Ben Batschelet"; SCRIPT_AUTHER_CONTACT="ben.batschelet@gmail.com"
    SCRIPT_DESCRIPTION="Tar /opt directory to a Samba mount."
    SCRIPT_TITLE="$SCRIPT_NAME - v$SCRIPT_VERSION - $SCRIPT_DATE - $SCRIPT_AUTHER ($SCRIPT_AUTHER_CONTACT) \n   ∟ Description: $SCRIPT_DESCRIPTION"
    echo -e " $(YEL "▶︎") $SCRIPT_TITLE";
}

# tar -cf archive.tar -X exclude.txt /opt

# ----------------------------------------------------------------------------------------------------------------------
# General Usage: sh "/mnt/usb8gb/active_system/scripts/backup/archive_opt.sh"
# ======================================================================================================================
# Notes:
#   Uses Color Functions Script (source /.../color_text_functions.sh)
# ======================================================================================================================
# [# Global Static Variables #]
SCRIPT_FILENAME="$(basename $0)"
SCRIPT_DIRECTORY="$(dirname $0)"
SCRIPT_DEPENDENCIES_DIRECTORY="$SCRIPT_DIRECTORY/dependencies"  # This Scripts Specific Dependencies
#   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
OS_VERSION=$(nvram get os_version)
OS_VERSION_UNDERSCORED=$(nvram get os_version | sed -e 's/ /_/g')

# [# Passed Variables Defaults #]
main_archive_destination_directory_name_prefix="tomato_router_archive"
main_archive_destination_directory_name_suffix=""
main_archive_destination_directory_root="/cifs1/Router"
main_archive_retention_number=120  # Number of archives to keep
main_archive_note="$OS_VERSION_UNDERSCORED"
main_archive_exclude_file="$SCRIPT_DIRECTORY/archive_exclude.conf"

echo "[# Loading Dependencies & Source Scripts #]"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/color_text_functions.sh"
#   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_file_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_folder_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_folder_archive_functions.sh"

# [# Functions #] ------------------------------------------------------------------------------------------------------

WHT "[# Running Archive #]"
# Output Script Title
ScriptInfo_archive_opt

WHT "[# Starting Archive #]" # -----------------------------------------------------------------------------------------
backupArchive "Archive /opt to Samba Mount" "/opt" "$main_archive_destination_directory_root" "$main_archive_destination_directory_name_prefix" "$main_archive_note" "$main_archive_destination_directory_name_suffix" "$main_archive_retention_number" "$main_archive_exclude_file"
