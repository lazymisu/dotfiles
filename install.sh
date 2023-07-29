#!/bin/bash

function set_gitconfig() {
	default_git_path="~/"
	read -p "user email: " git_email
	read -p "user name: " git_name
	read -p "path (default $default_git_path): " git_path
	git_path=${git_path:-$default_git_path}

	cat << EOF > $git_path
[user]
    email = $git_email
    name = $git_name
EOF
}

echo "Lazy(misu) Install Script"

echo "installing brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "installing apps..."
brew bundle

echo "exporting ruby PATH..."
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

echo "copying config files..."
cp -R .config ~/
cp Brewfile ~/Brewfile

echo "adding default git config..."
set_gitconfig

read -p "configure another git? (y/n): " choice
if ["$choice" == "y"] || ["$choice" == "Y"]; then
	set_gitconfig
fi

echo "Completed successfully!"
