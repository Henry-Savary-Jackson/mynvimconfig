#!/bin/sh

echo installing python venv for neovim
python -m venv venv

source venv/bin/activate

pip install pynvim

dir_name=$(echo $PWD | sed -E 's|(.*?)/(.*$)|\2|')

if [ "$HOME/$dir_name" != "$PWD" ]; then
  echo "neovim config installed in wrong directory!"
  exit 1
fi

echo "removing old config"
if [ ! -a "~/.local/share/nvim" ]; then
	echo "removing ~/.local/share/nvim"
  rm -rf ~/.local/share/nvim
fi
if [ ! -a "~/.local/state/nvim" ]; then
	
	echo "removing ~/.local/state/nvim"
  rm -rf ~/.local/state/nvim
fi
if [ ! -a "~/.config/nvim" ]; then
	
	echo "removing ~/.config/nvim"
  rm -rf ~/.config/nvim
fi

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
echo "Now putting config... "

if [ ! -a "$HOME/.config/nvim" ]; then
	rm -rf $HOME/.config/nvim
fi
ln -sf $(pwd)/nvim ~/.config/
