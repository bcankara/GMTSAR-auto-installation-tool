#!/bin/bash

#===================================================================================
# GMTSAR Installation Tool
# Version: 1.0.0
#===================================================================================
# Developer: Burak Can KARA
# Website: https://bcankara.com
# Email: burakcankara@gmail.com
# GitHub: https://github.com/bcankara
# ORCID: https://orcid.org/0000-0002-6933-0759
#===================================================================================
# License: MIT
# Copyright (c) 2025 Burak Can KARA
#===================================================================================

# Initial description
echo -e "\e[90m═══════════════════════════════════════════\e[0m"
echo -e "\e[37m         GMTSAR Installation Tool          \e[0m"
echo -e "\e[90m═══════════════════════════════════════════\e[0m"
echo -e "\e[90m Developer Information:\e[0m"
echo -e "\e[37m • Name     : Burak Can KARA\e[0m"
echo -e "\e[37m • Website  : https://bcankara.com\e[0m"
echo -e "\e[37m • Email    : burakcankara@gmail.com\e[0m"
echo -e "\e[37m • GitHub   : https://github.com/bcankara\e[0m"
echo -e "\e[37m • ORCID    : https://orcid.org/0000-0002-6933-0759\e[0m"
echo -e "\e[90m═══════════════════════════════════════════\e[0m"
echo
echo -e "\e[37mProcess Steps:\e[0m"
echo -e "\e[32m • System Setup\e[0m"
echo -e "\e[32m • Anaconda Setup\e[0m"
echo -e "\e[32m • GMTSAR Setup\e[0m"
echo -e "\e[32m • Environment Setup\e[0m"
echo
echo -e "\e[90m═══════════════════════════════════════════\e[0m"
echo -e "\e[37m              Continue? [Y/N]:             \e[0m"
echo -e "\e[90m═══════════════════════════════════════════\e[0m"

read -p "Your choice: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\e[31mInstallation cancelled.\e[0m"
    exit 1
fi

# Inform user: Granting sudo privileges
echo -e "\e[37mGranting sudo privileges...\e[0m"

# Add user to sudoers
USER=$(whoami)
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "\e[32mSudo privileges granted successfully.\e[0m"
else
    echo -e "\e[31mError: Failed to grant sudo privileges.\e[0m"
    exit 1
fi

# System preparation
echo -e "\n\e[37m[1/5] System Setup\e[0m"
echo -ne "      ▪ Preparing system...     "
sudo apt-get update -qq > /dev/null 2>&1
sudo apt-get upgrade -qq > /dev/null 2>&1
echo -e "\r      \e[32m✓\e[0m Preparing system                 "

echo -ne "      ▪ Installing packages...  "
sudo apt-get install -y -qq wget bash > /dev/null 2>&1
echo -e "\r      \e[32m✓\e[0m Installing packages              "

# Anaconda installation
echo -e "\n\e[37m[2/5] Anaconda Setup\e[0m"
echo -ne "      ▪ Downloading Anaconda... "

# Get Anaconda download URL
ANACONDA_URL=$(curl -s https://repo.anaconda.com/archive/ | grep -o 'Anaconda3-[0-9]*.[0-9]*-[0-9]*-Linux-x86_64.sh' | head -n 1 | awk -F'"' '{print "https://repo.anaconda.com/archive/"$1}')
if [ -z "$ANACONDA_URL" ]; then
    echo -e "\r      \e[31m✗\e[0m Failed to get Anaconda URL        "
    exit 1
fi

wget $ANACONDA_URL -O ~/anaconda_installer.sh -q
echo -e "\r      \e[32m✓\e[0m Downloading Anaconda              "

echo -ne "      ▪ Installing...          "
bash ~/anaconda_installer.sh -b -p $HOME/anaconda3 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "\r      \e[32m✓\e[0m Installing Anaconda              "
else
    echo -e "\r      \e[31m✗\e[0m Installation failed              "
    exit 1
fi

# Define content to be added
CONDA_INIT_CONTENT=$(cat <<EOF
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="\$('$HOME/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ \$? -eq 0 ]; then
    eval "\$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:\$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF
)

# Add content to .bashrc file
echo "$CONDA_INIT_CONTENT" >> ~/.bashrc

echo -ne "      ▪ Configuring...         "
bashrc_content=$(cat ~/.bashrc)
eval "$bashrc_content" 2> /dev/null
echo -e "\r      \e[32m✓\e[0m Configuring Anaconda              "

# Remove installation file
rm ~/anaconda_installer.sh > /dev/null 2>&1

# Install requirements
echo -e "\n\e[37m[3/5] GMTSAR Requirements\e[0m"
echo -ne "      ▪ Installing packages... "
sudo apt-get install -y -qq csh subversion autoconf libtiff5-dev libhdf5-dev wget > /dev/null 2>&1
sudo apt-get install -y -qq liblapack-dev gfortran g++ libgmt-dev gmt-dcw gmt-gshhg gmt > /dev/null 2>&1
echo -e "\r      \e[32m✓\e[0m Installing packages              "

echo -ne "      ▪ Preparing setup...     "
sudo chmod +x /home/$(ls /home | head -n 1)/gmtsar_setup.sh
echo -e "\r      \e[32m✓\e[0m Preparing setup                  "
sudo -i /home/$(ls /home | head -n 1)/gmtsar_setup.sh
