if ! grep -q 'includeIf "gitdir:~/workspace/personal/"' ~/.gitconfig
then
echo '
[includeIf "gitdir:~/workspace/personal/"]
    path = ~/workspace/personal/.gitconfig
' >> ~/.gitconfig
fi

mkdir -p ~/workspace/personal/

cp config_file/gitconfig ~/workspace/personal/.gitconfig