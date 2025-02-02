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
# Environment Setup Header
echo -e "\n\e[37m[5/5] Environment Setup\e[0m"

echo -ne "      ▪ Loading settings...     "
if bashrc_content=$(cat /home/$(ls /home | head -n 1)/.bashrc) && \
   eval "$bashrc_content" 2> /dev/null; then
    echo -e "\r      \e[32m✓\e[0m Loading settings                  "
else
    echo -e "\r      \e[31m✗\e[0m Failed to load settings          "
    exit 1
fi

echo -ne "      ▪ Creating environment... "
if conda create -y -n GMTSAR > /dev/null 2>&1; then
    echo -e "\r      \e[32m✓\e[0m Creating environment              "
else
    echo -e "\r      \e[31m✗\e[0m Failed to create environment      "
    exit 1
fi

echo -ne "      ▪ Activating GMTSAR...   "
if conda activate GMTSAR 2>/dev/null; then
    echo -e "\r      \e[32m✓\e[0m Activating GMTSAR                "
else
    echo -e "\r      \e[31m✗\e[0m Failed to activate GMTSAR        "
    exit 1
fi

echo -ne "      ▪ Setting PATH...        "
if echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc; then
    echo -e "\r      \e[32m✓\e[0m Setting PATH                     "
else
    echo -e "\r      \e[31m✗\e[0m Failed to set PATH               "
    exit 1
fi

echo -ne "      ▪ Setting default env... "
if echo 'conda activate GMTSAR' >> /home/$(ls /home | head -n 1)/.bashrc; then
    echo -e "\r      \e[32m✓\e[0m Setting default environment       "
else
    echo -e "\r      \e[31m✗\e[0m Failed to set default environment "
    exit 1
fi

echo -ne "      ▪ Updating environment... "
if bashrc_content=$(cat /home/$(ls /home | head -n 1)/.bashrc) && \
   eval "$bashrc_content" 2> /dev/null; then
    echo -e "\r      \e[32m✓\e[0m Updating environment             "
else
    echo -e "\r      \e[31m✗\e[0m Failed to update environment     "
    exit 1
fi

echo -e "\n\e[37mVerifying Installation:\e[0m"
required_commands=("esarp" "phasediff" "p2p_processing.csh")
missing_commands=()

for cmd in "${required_commands[@]}"; do
    echo -ne "      ▪ Checking $cmd..."
    printf '%*s' $((20 - ${#cmd})) ""
    if command -v $cmd &> /dev/null; then
        echo -e "\r      \e[32m✓\e[0m Checking $cmd                    "
    else
        echo -e "\r      \e[31m✗\e[0m $cmd not found                   "
        missing_commands+=($cmd)
    fi
done

echo -e "\n\e[90m═══════════════════════════════════════════\e[0m"
if [ ${#missing_commands[@]} -eq 0 ]; then
    echo -e "\e[32m         Installation Complete              \e[0m"
else
    echo -e "\e[31m         Installation Incomplete            \e[0m"
    echo -e "\e[31m         Missing: ${missing_commands[*]}    \e[0m"
    exit 1
fi
echo -e "\e[90m═══════════════════════════════════════════\e[0m"
