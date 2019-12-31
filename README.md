# Dotfiles repo

...because I'm tired of re-configuring everything every time. =_=

## Prerequirements

First of all, you need to install `zsh`, `oh-my-zsh` and `nvim`.

Optionally, you can install `Sublime Text 3` and/or `VS Code` -- configs for them are provided as well.

## Usage

For `Sublime Text` and `VS Code` simply copy-paste config contents to the settings json file.

For `*rc` files: copy them into home directory, set the variables in `.shell_user_rc` to their actual value.

That should be enough for `zsh` and `oh-my-zsh` to be configured.

## nvim

1. Obtain neovim (https://github.com/neovim/neovim).
2. Obtain vim-pack (https://github.com/junegunn/vim-plug).
3. Compile `universal-ctags` from source -- `snap` package currently don't work with `tagbar` (https://github.com/universal-ctags/ctags).
4. Copy `nvim/init.vim` to `~/.config/nvim/init.vim`.
5. Don't forget to launch `:PlugInstall` on first launch!

The config provided is best suited for `Rust` usage with multiple projects within filesystem.

