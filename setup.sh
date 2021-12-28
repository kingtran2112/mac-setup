#! /bin/zsh
isApplicationExist() {
  command -v $1 &> /dev/null
}

#Install homebrew
echo "Start install homebrew"
if ! isApplicationExist brew
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Finish install homebrew"
else
  echo "Brew is already installed, skiped!!!"
fi

#Install iterm
echo "Start install iterm2"
brew install --cask iterm2
echo "Finish install iterm2"

#Install git
echo "Start install"
if ! isApplicationExist git
then
  brew install git
else
  echo "Git is already installed, skiped!!!"
fi

echo "Config git"
git config --global user.name "King Tran"
git config --global user.email "kingtran.2112@gmail.com"

# Install prezto
echo "Set up prezto"
if ! isApplicationExist prompt
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
  \cp -v zpreztorc ~/.zpreztorc

  echo "Finish install prezto"
else
  echo "Prezto is already installed, skiped!!!"
fi

applications=(visual-studio-code )

#Install visual studio code
echo "Start install vscode"
brew install --cask visual-studio-code
echo "Finish install vscode"
