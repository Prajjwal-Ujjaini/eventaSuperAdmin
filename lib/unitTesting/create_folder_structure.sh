#!/bin/bash

# Check if the user has provided both the folder name and the location
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <location> <folder_name>"
  exit 1
fi

# Get the folder name and location from the user input
location=$1
folder_name=$2

# Create the main folder at the specified location
mkdir -p "$location/$folder_name"

# Define the subfolders
subfolders=(components location model presentation provider service)

# Loop through the subfolders and create them
for subfolder in "${subfolders[@]}"; do
  mkdir -p "$location/$folder_name/$subfolder"
done

# Create the required files inside the subfolders
touch "$location/$folder_name/location/${folder_name}_location.dart"
touch "$location/$folder_name/model/${folder_name}_model.dart"
touch "$location/$folder_name/provider/${folder_name}_provider.dart"
touch "$location/$folder_name/service/${folder_name}_service.dart"
touch "$location/$folder_name/presentation/${folder_name}_screen.dart"

echo "Folder structure and files created successfully at $location/$folder_name."


# to run this
#  ./create_folder_structure.sh profile /media/zanwar/CommonData/flutter_Project/eventa_super_admin/lib/features