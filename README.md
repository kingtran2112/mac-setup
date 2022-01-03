# Requirements
* zsh
# Description

The repository contains the shell script and necessary files for setting
common application for a new mac OS system.

The list of application will be installed:
* Homebrew
* Iterm 2
* Git (and configuration for user name and email)
* Prezto (NOTE: The shell script override current configuration with the
defined configuration in the repository)
* VS Code

# How to run

To run the script:
* Open a terminal
* Run the following command in order
```bash
git clone https://github.com/kingtran2112/mac-setup.git
cd mac-setup
./setup.sh
cd ..
rm -rf mac-setup
```
The above script clone the repository, run the setup script and then
delete the cloned folder after finish
