#!/usr/bin/env bash


# exiftool aracının varlığını kontrol ediyor
check_exiftool_installed() {


    if ! command -v exiftool &>/dev/null; then 
        cat >&2 <<'EOF'
Hata: 'exiftool' bulunamadı. Bu araç çalışmadan önce kurulmalı.
 
Kurulum:
  Debian/Ubuntu : sudo apt install libimage-exiftool-perl
  macOS (brew)  : brew install exiftool
  Fedora        : sudo dnf install perl-Image-ExifTool
  Arch          : sudo pacman -S perl-image-exiftool
EOF

        exit 1

    fi 


}


# 'column' bazı varsayılan sistemlerde gelmez kontrol edelim 

check_column_installed() {


    if ! command -v column &>/dev/null; then
         cat >&2 <<'EOF'
Bilgi: 'column' bulunamadı, tablo çıktısı printf ile hizalanacak (daha az esnek ama bağımlılık gerektirmez).
  Tam hizalama için:
  Debian/Ubuntu : sudo apt install bsdextrautils
  macOS         : zaten sistemle birlikte gelir
EOF
        return 1
    fi 

    return 0


}