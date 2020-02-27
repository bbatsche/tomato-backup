#!/bin/sh

ScriptInfo_backup_router() {
    SCRIPT_NAME="Tomato Router Backup Script"; SCRIPT_VERSION="3.0"; SCRIPT_DATE="2020-02-27"; SCRIPT_AUTHER="Ben Batschelet"; SCRIPT_AUTHER_CONTACT="ben.batschelet@gmail.com"
    SCRIPT_DESCRIPTION="Selctively backup everything on your Tomato router"
    SCRIPT_TITLE="$SCRIPT_NAME - v$SCRIPT_VERSION - $SCRIPT_DATE - $SCRIPT_AUTHER ($SCRIPT_AUTHER_CONTACT) \n   ∟ Description: $SCRIPT_DESCRIPTION"
    echo -e " $(YEL "▶︎") $SCRIPT_TITLE";
}

# ----------------------------------------------------------------------------------------------------------------------
# General Usage: sh "/mnt/usb8gb/active_system/scripts/backup/backup_router_tomato.sh"
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
main_backup_destination_directory_name_prefix="tomato_router_backup"
main_backup_destination_directory_name_suffix=""
main_backup_destination_directory_root="/opt/backups"
main_backup_retention_number=120  # Number of backups to keep
main_backup_note="$OS_VERSION_UNDERSCORED"

echo "[# Loading Dependencies & Source Scripts #]"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/color_text_functions.sh"
#   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_file_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_folder_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_folder_archive_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_nvram_raw_functions.sh"
source "$SCRIPT_DEPENDENCIES_DIRECTORY/backup_sysinfo_functions.sh"

# [# Functions #] ------------------------------------------------------------------------------------------------------

WHT "[# Running Main #]"
# Output Script Title
ScriptInfo_backup_router

WHT "[# Running Backups #]"
# Output Script Title
ScriptInfo_backup_router

# Set Destination Path
main_backup_destination_directory_path="$main_backup_destination_directory_root/$main_backup_destination_directory_name_prefix"_"$(date +%Y-%m-%d_%H%M%S)"_"($OS_VERSION_UNDERSCORED)$main_backup_destination_directory_name_suffix"

# Purge/Cleanup Old Backups
cleanupFolder "$main_backup_destination_directory_root" $main_backup_retention_number ".*$main_backup_destination_directory_name_prefix.*"

WHT "[# Starting Backups #]" # --------------------------------------------------------------------------------------
backupSysinfo "Backup System Information" "$main_backup_destination_directory_path" "sysinfo_" "$main_backup_note" ".txt" "$main_backup_retention_number"
backupNVRamRAW "NVRam RAW Configuration" "$main_backup_destination_directory_path/NVRam" "tomato_nvram_raw_" "$main_backup_note" "_sufix.cfg" "$main_backup_retention_number"
