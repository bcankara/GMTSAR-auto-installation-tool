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
# Copyright (c) 2024 Burak Can KARA
#===================================================================================

# GMTSAR Installation Header
echo -e "\n\e[37m[4/5] GMTSAR Installation\e[0m"

echo -ne "      ▪ Preparing directory...  "
if cd /usr/local; then
    echo -e "\r      \e[32m✓\e[0m Preparing directory              "
else
    echo -e "\r      \e[31m✗\e[0m Failed to prepare directory      "
    exit 1
fi

echo -ne "      ▪ Getting latest version... "
LATEST_VERSION=$(curl -s https://api.github.com/repos/gmtsar/gmtsar/releases/latest | grep tag_name | cut -d '"' -f 4)
if [ ! -z "$LATEST_VERSION" ]; then
    echo -e "\r      \e[32m✓\e[0m Getting latest version            "
else
    echo -e "\r      \e[31m✗\e[0m Failed to get version             "
    exit 1
fi

echo -ne "      ▪ Cloning repository...   "
if git clone --branch $LATEST_VERSION https://github.com/gmtsar/gmtsar GMTSAR > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Cloning repository                "
else
    echo -e "\r      \e[31m✗\e[0m Failed to clone repository        "
    exit 1
fi

echo -ne "      ▪ Setting permissions...  "
if sudo chown -R $USER GMTSAR > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Setting permissions               "
else
    echo -e "\r      \e[31m✗\e[0m Failed to set permissions         "
    exit 1
fi

cd GMTSAR
echo -ne "      ▪ Running autoconf...     "
if autoconf > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Running autoconf                  "
else
    echo -e "\r      \e[31m✗\e[0m Failed to run autoconf            "
    exit 1
fi

echo -ne "      ▪ Running autoupdate...   "
if autoupdate > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Running autoupdate                "
else
    echo -e "\r      \e[31m✗\e[0m Failed to run autoupdate          "
    exit 1
fi

echo -ne "      ▪ Configuring build...    "
if ./configure --with-orbits-dir=/usr/local/orbits > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Configuring build                 "
else
    echo -e "\r      \e[31m✗\e[0m Failed to configure build         "
    exit 1
fi

echo -ne "      ▪ Updating flags...       "
if sed -i '/^CFLAGS/s/$/ -z muldefs/' config.mk > /dev/null 2>&1 && \
   sed -i '/^LDFLAGS/s/$/ -z muldefs/' config.mk > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Updating flags                    "
else
    echo -e "\r      \e[31m✗\e[0m Failed to update flags            "
    exit 1
fi

echo -ne "      ▪ Installing make...      "
if ! command -v make &> /dev/null; then
    if sudo apt-get install -y -qq make > /dev/null 2>&1; then
        echo -e "\r      \e[32m✓\e[0m Installing make                   "
    else
        echo -e "\r      \e[31m✗\e[0m Failed to install make           "
        exit 1
    fi
else
    echo -e "\r      \e[32m✓\e[0m Make already installed              "
fi

echo -ne "      ▪ Compiling GMTSAR...    "
if make -s > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Compiling GMTSAR                  "
else
    echo -e "\r      \e[31m✗\e[0m Failed to compile GMTSAR          "
    exit 1
fi

echo -ne "      ▪ Installing GMTSAR...   "
if make -s install > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Installing GMTSAR                 "
else
    echo -e "\r      \e[31m✗\e[0m Failed to install GMTSAR         "
    exit 1
fi

cd ~
echo -ne "      ▪ Setting GMTSAR path... "
echo 'export GMTSAR=/usr/local/GMTSAR' >> /home/$(ls /home | head -n 1)/.bashrc
echo -e "\r      \e[32m✓\e[0m Setting GMTSAR path                "

echo -ne "      ▪ Updating PATH...       "
echo 'export PATH=$GMTSAR/bin:"$PATH"' >> /home/$(ls /home | head -n 1)/.bashrc
echo -e "\r      \e[32m✓\e[0m Updating PATH                      "

# Reload Configuration
bashrc_content=$(cat /home/$(ls /home | head -n 1)/.bashrc)
eval "$bashrc_content" 2> /dev/null

echo -ne "      ▪ Preparing env setup... "
if sudo chmod +x /home/$(ls /home | head -n 1)/env_setup.sh > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Preparing env setup                "
else
    echo -e "\r      \e[31m✗\e[0m Failed to prepare env setup        "
    exit 1
fi

# Launch Environment Setup
su -l $(ls /home | head -n 1) -c "bash /home/$(ls /home | head -n 1)/env_setup.sh"
