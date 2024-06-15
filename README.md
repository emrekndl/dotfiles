# My dotfiles

This directory contains the dotfiles for my system

## Requirements

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/emrekndl/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks.

```
$ stow nvim zshrc ...
```

Cleaning up symbolic links.
```
stow -D nvim
```
