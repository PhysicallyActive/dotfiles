#!/bin/bash -eu

# Inspired By Learn Linux TV - https://www.youtube.com/watch?v=e7bezUA6G4g

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
CPK="[\e[1;36mPKG\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
INSTLOG="installation.log"

install_dependencies() {
  echo -e "$CNT - Installing depdencies"
  sudo apt install i3 feh imagemagick rofi
  echo -e "$COK - Depdencies installed"
}

install_greenclip() {
  CH="greenclip"
  echo -e "$CNT - Downloading binaries for $CH (v4.2)"
  wget -q https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
  echo -e "$CNT - Setting permissions for $CH"
  chmod +x $CH
  echo -e "$CNT - Moving $CH binaries to $HOME/.local/bin"
  cp $CH "$HOME/.local/bin"
  rm -rf $CH
  echo -e "$COK - $CH was installed"
}

# function that backs up potential existing data and then overwrites it with a symlink to the new folders
backup_and_link() {
  SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
  CONFIG_DIR="$HOME/.config"
  BACKUP_DIR="$HOME/backups"
  SOURCE="$1"
  TARGET="$2"

  mkdir -p $BACKUP_DIR

  # Backup target folder if it exists
  if [[ -d "$CONFIG_DIR/$TARGET" ]]; then
    TIMESTAMP=$(date +%Y%m%d%H%M)
    echo -e "$CNT - Creating backup $BACKUP_DIR/$TARGET.bak.$TIMESTAMP"
    cp -rL "$CONFIG_DIR/$TARGET" "$BACKUP_DIR/$TARGET.bak.$TIMESTAMP"

    rm -rf "$CONFIG_DIR/$TARGET"
  fi

  ln -sf "$SCRIPT_DIR/$SOURCE" "$CONFIG_DIR/$TARGET"
  echo -e "$COK - Symlink created from $SCRIPT_DIR/$SOURCE to $CONFIG_DIR/$TARGET"
}

add_rofi_configs() {
  rofi_themes_dir="$HOME/.local/share/rofi/themes"
  config_dir="$HOME/.config"

  backup_and_link "rofi" "rofi"

  mkdir -p "$rofi_themes_dir"
  if [[ -d "$config_dir/catppuccin-mocha.rasi" ]]; then
    rm -rf "$config_dir/catppuccin-mocha.rasi"
  fi

  ln -sf "$config_dir/catppuccin-mocha.rasi" "$rofi_themes_dir/catppuccin-mocha.rasi"
}

main() {
  # set some expectations for the user
  echo -e "$CNT - You are about to execute a script that would attempt to setup i3."

  # attempt to discover if this is a VM or not
  echo -e "$CNT - Checking for Physical or VM..."
  ISVM=$(hostnamectl | grep Chassis)
  echo -e "Using $ISVM"
  if [[ $ISVM == *"vm"* ]]; then
    echo -e "$CWR - Please note that VMs are not fully supported and if you try to run this on
    a Virtual Machine there is a high chance this will fail."
    sleep 1
  fi

  # let the user know that we will use sudo
  echo -e "$CNT - This script will run some commands that require sudo. You will be prompted to enter your password. If you are worried about entering your password then you may want to review the content of the script."

  # give the user an option to exit out
  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' CONTINST
  if [[ $CONTINST != "Y" && $CONTINST != "y" ]]; then
    echo -e "$CNT - This script will now exit, no changes were made to your system."
    exit
  fi
  echo -e "$CNT - Setup starting..."

  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install required dependencies (y,n) ' CONTINST
  if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    install_dependencies
  fi

  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install a clipboard manager? (y,n) ' CONTINST
  if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    install_greenclip
  fi

  ### Copy Config Files ###
  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
  if [[ $CFG == "Y" || $CFG == "y" ]]; then

    # Make all shell-scripts in this folder executable
    SCRIPT_NAME="$(basename $0)"
    SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
    echo -e "$CNT - Making all shell-scripts in $SCRIPT_DIR executable"
    find $SCRIPT_DIR -type f -name "*.sh" | while read -r FILE; do
      if [[ "$(basename "$FILE")" != $SCRIPT_NAME ]]; then
        chmod +x $FILE
        echo -e "$COK - $FILE made executable"
      fi
    done

    echo -e "$CNT - Copying config files..."
    # backup_and_link "i3" "i3"
    # backup_and_link "backgrounds" "backgrounds"
    add_rofi_configs
  fi

}

main
echo -e "$CNT - Script has completed!"
