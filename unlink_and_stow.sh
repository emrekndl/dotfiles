#!/usr/bin/env zsh

# Dotfiles dizini ve içinde yönetilecek paketler
DOTFILES="${HOME}/dotfiles"
STOW_FOLDERS="zsh,tmux,nvim"

# Dotfiles dizinine geç
pushd "$DOTFILES" > /dev/null

# Her paket için önce kaldır, sonra yeniden kur
for pkg in ${(s:,,:)STOW_FOLDERS}; do
  echo "→ Unstowing $pkg (removing old symlinks)"
  stow -D "$pkg"

  echo "→ Stowing $pkg (creating new symlinks)"
  stow "$pkg"
done

# Orijinal dizine geri dön
popd > /dev/null

