#!/bin/sh

if [ ! -a "~/.local/share/nvim" ]; then
	rm -rf ~/.local/share/nvim
fi
if [ ! -a "~/.local/state/nvim" ]; then
	rm -rf ~/.local/state/nvim
fi
if [ ! -a "~/.config/nvim" ]; then
	rm -rf ~/.config/nvim
fi

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
echo "Now putting config... "

if [ ! -d "$HOME/.config/nvim" ]; then
	rm -rf ~/.config/nvim
fi
ln -sf $(pwd)/nvim-config/nvim ~/.config/
