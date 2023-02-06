#! /bin/zsh
# ---Util function---
isCommandExist() {
  command -v $1 &> /dev/null
}

# Check if the application is exist in /Applications folder
isApplicationExist() {
  [[ -d /Applications/$1.app ]]
}

# ---Main function---
#Install homebrew
echo "Start install homebrew"
if ! isCommandExist brew
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
    
  echo "Finish install homebrew"
else
  echo "Brew is already installed, skiped!!!"
fi

#Install git
echo "Start install"
if ! isCommandExist git
then
  brew install git
else
  echo "Git is already installed, skiped!!!"
fi

echo "Config git"

read "githubName?Input github name: "
git config --global user.name $githubName
read "githubEmail?Input github email: "
git config --global user.email $githubEmail

git config --global init.defaultBranch main
git config pull.rebase true

# Install prezto
echo "Set up prezto"
if [[ ! -d ${ZDOTDIR:-$HOME}/.zprezto ]]
then
  echo "Start install prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  echo "Set zsh as default shell"
  chsh -s /bin/zsh

  echo "Update zpreztorc file"
  # By default, cp may run with -i flag (check by {@link alias | grep cp})
  # so we use backward slash to avoid it
  # We can also use sed command to change the configuration or add the module
  # we want but we think directly copy it like this is more straightforward and easier
  \cp -v dotfile/.zpreztorc ~/.zpreztorc

  echo "Finish install prezto"
else
  echo "Prezto is already installed, skiped!!!"
fi

declare -A applications

applications=(
  ["Visual Studio Code"]="visual-studio-code"
  ["Google Chrome"]="google-chrome"
  ["Warp"]="warp"
  ["Slack"]="slack"
  ["Discord"]="discord"
  ["Hammerspoon"]="hammerspoon"
  ["Rectangle"]="rectangle"
  ["Obsidian"]="obsidian"
)

installApplication=()

# Checking if application exist and add homebrew name of the un-installed 
# application to $installApplication
for applicationName in ${(k)applications}; do
  if ! isApplicationExist $applicationName;
  then
    installApplication+=($applications[$applicationName])
  else
    echo "$applicationName is exist, skip install!!!"
  fi
done

# Install application in $installApplication by homebrew
for application in $installApplication; do
  echo "Start install ${application}"
  brew install --cask $application
  echo "Finish install ${application}"
done

# https://code.visualstudio.com/docs/setup/mac#_alternative-manual-instructions
cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

brew cleanup
