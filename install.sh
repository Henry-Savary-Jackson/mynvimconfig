#!/bin/sh

if [ "$HOME/mynvimconfig" != "$PWD" ]; then
  echo "nvimconfig installed in wrong directory!"
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
