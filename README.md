# GMTSAR Auto Installation Tool

<p align="center">
  <img src="https://raw.githubusercontent.com/bcankara/autoGMTSAR/refs/heads/main/assets/img.png" alt="GMTSAR Auto Installation Tool Logo" width="50%">
</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An automated installation script for GMTSAR (Generic Mapping Tools Synthetic Aperture Radar) on Ubuntu systems.

## Description

This tool automates the installation process of GMTSAR and its dependencies, making it easier for researchers and professionals to set up their InSAR processing environment. The script handles the complete installation process including system preparation, Anaconda setup, GMTSAR installation, and environment configuration.

## Features

- 🚀 Automated installation of GMTSAR and all dependencies
- 🔧 Automatic system preparation and configuration
- 📦 Anaconda environment setup
- ⚙️ PATH and environment variable configuration
- ✅ Installation verification system
- 🛡️ Error handling and validation

## Prerequisites

- Ubuntu operating system
- Internet connection
- Sudo privileges

## Installation

1. **Clone the repository:**
```bash
git clone https://github.com/bcankara/autoGMTSAR.git
```

2. **Move installation files to home directory:**

Note: The installation files must be in your home directory (`/home/username/`) for proper installation.

```bash
cd autoGMTSAR
```
```bash
cp installer.sh gmtsar_setup.sh env_setup.sh ~/
```
```bash
cd ~
```

3. **Make the script executable:**
```bash
chmod +x installer.sh
```

4. **Run the installation script:**
```bash
bash installer.sh
```


## Installation Steps

1. **System Setup**
   - System update and upgrade
   - Installation of required packages

2. **Anaconda Setup**
   - Download and installation of latest Anaconda
   - Configuration of Anaconda environment

3. **GMTSAR Requirements**
   - Installation of GMTSAR dependencies
   - System library setup

4. **GMTSAR Installation**
   - Download and compilation of GMTSAR
   - Configuration of build environment
   - Installation of GMTSAR binaries

5. **Environment Setup**
   - Configuration of environment variables
   - PATH setup
   - Installation verification

## Developer

- **Name:** Burak Can KARA
- **Website:** https://bcankara.com
- **Email:** burakcankara@gmail.com
- **GitHub:** https://github.com/bcankara
- **ORCID:** https://orcid.org/0000-0002-6933-0759

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Keywords

InSAR, GMTSAR, SAR Processing, Remote Sensing, Geodesy, Earth Observation, Radar Interferometry, Scientific Computing, Automation, Installation Script, Ubuntu, Anaconda, GMT, Generic Mapping Tools

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to check [issues page](https://github.com/bcankara/gmtsar-installer/issues) if you want to contribute.

## Support

For support, please contact via email or create an issue in the repository.

---
© 2024 Burak Can KARA - All Rights Reserved 