ScriptInfo_backup_folder_archive_functions() {
SCRIPT_NAME="Backup Folder Archive"; SCRIPT_VERSION="3.0"; SCRIPT_DATE="2020-02-20"; SCRIPT_AUTHER="Ben Batschelet"; SCRIPT_AUTHER_CONTACT="ben.batschelet@gmail.com"
SCRIPT_DESCRIPTION="Used to backup a single folder"
SCRIPT_TITLE="Dependency: $SCRIPT_NAME - v$SCRIPT_VERSION - $SCRIPT_DATE - $SCRIPT_AUTHER ($SCRIPT_AUTHER_CONTACT) \n   ∟ Description: $SCRIPT_DESCRIPTION"
echo -e " $(YEL "▶︎") $SCRIPT_TITLE"; }
# -------------------------------------------------------------------------------------------------
# Initialisation: sh "/../backup_folder_archive.sh" "SCRIPTS_DEPENDENCIES_DIRECTORY (Glodal)" "SCRIPT_DIRECTORY (Spacific)"
# General Usage: backupArchive "backup_task_name" "backup_source" "backup_destination_directory" "backup_destination_filename_prefix" "backup_note" "backup_destination_filename_suffix" "backup_retention_number"
# =================================================================================================
# Notes:
#	Uses Color Functions Script (source /.../color_text_functions.sh)
# =================================================================================================
# Check if this script is already loaded
if [ -z $script_loaded_backup_folder_archive_functions ]; then
	# Output Script Title
	ScriptInfo_backup_folder_archive_functions

	# [# Global Static Variables #]
	SCRIPT_DIRECTORY="$(dirname $0)"  # This Script Sets Specific Directory (shows root most script directory, so if a script sources this script then this script will not output its directory... )
	SCRIPT_DEPENDENCIES_DIRECTORY="$SCRIPT_DIRECTORY"  # This Script Sets Specific Dependencies

	# [# Included Libraries & Scripts #] --------------------------------------------------------------------------------------
	source "$SCRIPT_DEPENDENCIES_DIRECTORY/files_and_folder_functions.sh"
	source "$SCRIPT_DEPENDENCIES_DIRECTORY/color_text_functions.sh"

	# [# Functions #] --------------------------------------------------------------------------------------
	# ALL SOURCED & INCLUDED

	# [# Main Function #] --------------------------------------------------------------------------------------
	backupArchive()
	{ # backupArchive "backup_task_name" "backup_source" "backup_destination_directory" "backup_destination_filename_prefix" "backup_destination_filename_suffix" "backup_retention_number" "backup_note"
		# [# Read Passed Varables #] --------------------------------------------------------------------------------------
		BRK 2

		# [# Passed Variables Defaults #] Load Default Varables
		backup_task_name="Backup Folder to Archive"
		backup_source=""
		backup_destination_directory=""
		backup_destination_filename_prefix=""  # "prefix_"
		backup_note="note"
		backup_destination_filename_suffix=""  # "_suffix"
		backup_retention_number=64

		# Set Backup Task Name
		if [ -z "$1" ]; then
			YEL "Backup Task Name $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Task Name $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_task_name="$1"
		fi
		BLU "∟ Using: $(WHT "$backup_task_name")"

		# Set Backup Source Folder Path
		if [ -z "$2" ]; then
			YEL "Backup Source Folder Path $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Source Folder Path $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_source="$2"
		fi
		BLU "∟ Using: $(WHT "$backup_source")"

		# Set Backup Root Destination Directory
		if [ -z "$3" ]; then
			YEL "Backup Root Destination Directory $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Root Destination Directory $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_destination_directory="$3"
		fi
		BLU "∟ Using: $(WHT "$backup_destination_directory")"

		# Set Backup Destination Filename Prefix
		if [ -z "$4" ]; then
			YEL "Backup Destination Filename Prefix $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Destination Filename Prefix $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_destination_filename_prefix="$4"
		fi
		BLU "∟ Using: $(WHT "$backup_destination_filename_prefix")"

		# Set Backup Note ( Is put on Destination File)
		if [ -z "$5" ]; then
			YEL "Backup Note $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Note $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_note="$5"
		fi
		BLU "∟ Using: $(WHT "$backup_note")"

		# Set Backup Destination Filename Suffix
		if [ -z "$6" ]; then
			YEL "Backup Destination Filename Suffix $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Backup Destination Filename Suffix $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_destination_filename_suffix="$6"
		fi
		BLU "∟ Using: $(WHT "$backup_destination_filename_suffix")"

		# Set Number of Backups to Keep (Of same Prefix & Suffix in Destination Directory)
		if [ -z "$7" ]; then
			YEL "Number of Backups to Keep $(WHT "[") $(RED "NOT Passed") $(WHT "]")"
		else
			YEL "Number of Backups to Keep $(WHT "[") $(GRN "Passed") $(WHT "]")"
			backup_retention_number="$7"
		fi
		BLU "∟ Using: $(WHT "$backup_retention_number")"

		# [# Main #] --------------------------------------------------------------------------------------
		# [# Variables #]
		backup_destination_filename="$backup_destination_filename_prefix$(date +%Y-%m-%d_%H%M%S)_($backup_note)$backup_destination_filename_suffix.tar.gz"  # "$backup_destination_filename_prefix"_"$(date +%Y-%m-%d_%H%M%S)"_"($backup_note)$backup_destination_filename_suffix"
		backup_destination_path="$backup_destination_directory/$backup_destination_filename"

		# [# Output Task #]
		BRK 2
		WHT "Backup Folder Archive Task: $backup_task_name ($backup_note)"
		WHT "Source:      $backup_source"
		WHT "Destination: $backup_destination_path"

		# Purge/Cleanup Old Backups
		cleanupFile "$backup_destination_directory" $backup_retention_number ".*$backup_destination_filename_prefix.*$backup_destination_filename_suffix"

		# Create Backup Folder for This Backup
		checkFolder "$backup_destination_directory"

		# Create Archive from Folder
		NRM "Archiving: $(BLK "$backup_source") -> $(BLK "$backup_destination_path")"
		# Check if Source & Destination Exist
		if [ -d "$backup_source" ] && [ -d "$backup_destination_directory" ]; then
			# Preform standard opterations
			tar -zcf "$backup_destination_path" "$backup_source"
		else
			WRN "Backup Source or Destination NOT Valid"
		fi

		# Output
		BRK 8
	}

	# Set Script Initialize Variable
	script_loaded_backup_folder_archive_functions=true
fi
