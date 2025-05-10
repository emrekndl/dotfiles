#!/usr/bin/env bash
# Arch Linux GNOME Development Environment Setup Script
# Kullanıma başlamadan önce bu dosyayı okumayı unutmayın!
#
#  TODO: cli and gui apps will be check for true installation!!!(package names, dependecies, repos, etc.) 
# Example
# #!/usr/bin/env bash
# sudo pacman -S zsh
# hash -r
# sudo chsh -s $(which zsh)
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# Katı Bash Seçenekleri: Hata yakalama ve güvenli script davranışı için
set -euo pipefail  # -e: hata durumunda çık, -u: tanımsız değişken hata, -o pipefail: pipe hatalarını algıla
trap 'echo "[HATA] Komut başarısız oldu! Çıkış kodu: $?"' ERR
IFS=$'\n\t'  # IFS'yi sadece yeni satır ve tab olarak ayarla

# İsteğe bağlı debug modu
# DEBUG=true ./script.sh
[[ "${DEBUG:-}" == "true" ]] && set -x

### Kullanıcıdan Git Ayarları
GIT_USER_NAME=""   # Git kullanıcı adınızı buraya yazın
GIT_USER_EMAIL=""  # Git e-posta adresinizi buraya yazın

### Paket Yöneticileri Komutları
PACMAN_CMD="sudo pacman --noconfirm --needed -Sy"
AUR_HELPER_CMD="paru --noconfirm --needed"

### Kurulacak Paket Grupları
# CLI Uygulamaları
cli_pacman=(curl git zsh tmux nvim ripgrep fzf tldr httpie parallel jq yt-dlp yazi imagemagick podman ffmpeg alsa-utils gparted)
# Geliştirme Dilleri ve Araç Zinciri
dev_pacman=(python go gcc clang make cmake jdk-openjdk nodejs npm)
# GNOME Masaüstü Temel Bileşenleri
desktop_pacman=(gnome-shell gnome-terminal)
# AUR CLI Uygulamaları
cli_aur=(oh-my-zsh-git powerlevel10k-git)
# AUR GUI Uygulamaları
gui_aur=(ghosstty zen-browser-bin chromium dbeaver spotube xdm libreoffice-fresh conky-lua variety rofi-nerd-icons noiseTorch-bin zapret code)
# Son kurulum özeti ve sistem bilgisini göstermek için
extra_pacman=(pfetch)

### Dotfiles Reposu ve Modülleri
DOTFILES_REPO="https://github.com/emrekndl/dotfiles.git"
DOTFILES_DIR="${HOME}/dotfiles"
declare -a DOTFILES_MODULES=(alacritty conky ghostty nvim powerlevel10k rofi scripts tmux zshrc)

### Fonksiyon: Paru (AUR Helper) Kurulumu
install_paru() {
  echo "[*] Paru yükleniyor (AUR Helper)..."
  sudo pacman --noconfirm --needed -Sy base-devel git
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/paru.git "$tmpdir"
  cd "$tmpdir"
  makepkg -si --noconfirm
  cd -
  rm -rf "$tmpdir"
}

### Fonksiyon: SSH Anahtarı Kontrolü ve Oluşturma
check_ssh_key() {
  if [[ ! -f "$HOME/.ssh/id_ed25519.pub" ]]; then
    echo "[i] SSH anahtarınız bulunamadı. Oluşturuluyor..."
    ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
    echo "[i] Oluşturulan public anahtarınızı GitHub'a ekleyin:"
    echo "$(cat $HOME/.ssh/id_ed25519.pub)"
    read -rp "Anahtar GitHub'a eklendi mi? (y/n): " ans
    [[ "$ans" != "y" ]] && echo "Anahtarı GitHub'a ekleyip script'i tekrar çalıştırın." && exit 1
  else
    echo "[i] SSH anahtarınız zaten mevcut."
  fi
}

### Fonksiyon: Paket Kurulumu
install_packages() {
  echo "[*] Pacman CLI paketleri kuruluyor..."
  $PACMAN_CMD "${cli_pacman[@]}"
  echo "[*] Pacman development paketleri kuruluyor..."
  $PACMAN_CMD "${dev_pacman[@]}"
  echo "[*] Pacman GNOME bileşenleri kuruluyor..."
  $PACMAN_CMD "${desktop_pacman[@]}"
  echo "[*] Ek paketler (pfetch) kuruluyor..."
  $PACMAN_CMD "${extra_pacman[@]}"

  echo "[*] AUR CLI paketleri kuruluyor..."
  $AUR_HELPER_CMD "${cli_aur[@]}"
  echo "[*] AUR GUI paketleri kuruluyor..."
  $AUR_HELPER_CMD "${gui_aur[@]}"
}

### Fonksiyon: Git Global Ayarlarını Yap
setup_git() {
  if [[ -z "$GIT_USER_NAME" || -z "$GIT_USER_EMAIL" ]]; then
    echo "[!] Git kullanıcı adı veya e-posta ayarlanmadı. Lütfen değişkenleri doldurun."
    exit 1
  fi
  git config --global user.name "$GIT_USER_NAME"
  git config --global user.email "$GIT_USER_EMAIL"
  echo "[*] Git global ayarları yapıldı: $GIT_USER_NAME <$GIT_USER_EMAIL>"
}

### Fonksiyon: Dotfiles Kurulumu ve Stow\setup_dotfiles() {
  echo "[*] Dotfiles yükleniyor..."
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "[i] Mevcut dotfiles dizini bulundu. Güncelleniyor..."
    git -C "$DOTFILES_DIR" pull
  else
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
  cd "$DOTFILES_DIR"
  echo "[*] Stow ile yapılandırmalar uygulanıyor..."
  for module in "${DOTFILES_MODULES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$module" ]]; then
      stow -v -R "$module"
    else
      echo "[!] $module modülü bulunamadı, atlanıyor."
    fi
  done
  echo "[*] Dotfiles uygulandı."
}

### Ana Kurulum Akışı
main() {
  echo "=============================================="
  echo " Arch Linux Development Environment Setup Starting... "
  echo "=============================================="

  install_paru
  check_ssh_key
  install_packages
  setup_git
  setup_dotfiles

  echo "=============================================="
  echo " Kurulum Tamamlandı! İşlem Özeti: "
  echo "- CLI paketleri: ${#cli_pacman[@]}"
  echo "- Dev paketleri: ${#dev_pacman[@]}"
  echo "- GNOME bileşenleri: ${#desktop_pacman[@]}"
  echo "- Ek paketler: ${#extra_pacman[@]}"
  echo "- AUR CLI: ${#cli_aur[@]}"
  echo "- AUR GUI: ${#gui_aur[@]}"
  echo "=============================================="
  pfetch
}

main "$@"

