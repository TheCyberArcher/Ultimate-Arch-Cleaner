

echo '                  -`'
echo '                 .o+`'
echo '                `ooo/'
echo '               `+oooo:'
echo '              `+oooooo:'
echo '              -+oooooo+:'
echo '            `/:-:++oooo+:'
echo '           `/++++/+++++++:'
echo '          `/++++++++++++++:'
echo '        `/+++ooooooooooooo/`'
echo '        ./ooosssso++osssssso+`'
echo '       .oossssso-````/ossssss+`'
echo '      -osssssso.      :ssssssso.'
echo '     :osssssss/        osssso+++.'
echo '    /ossssssss/        +ssssooo/-'
echo '  `/ossssso+/:-        -:/+osssso+-'
echo ' `+sso+:-`  TheCyberArcher  `.-/+oso:'
echo '`++:.                           `-/+/'
echo '.`                                 ` '

echo '====== ARHCLINUX CLEAN SCRIPT ====='
echo ''
echo "This script allows you to clean your archlinux distribution and will delete your temporary folders, logs, orphan packages, the pacman/yay cache, the cache of your flatpak applications, old configurations, update your mirrors and update your system."

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

echo ''
echo "do you want to proceed ?"
echo ''
yes_or_no "$message"

echo ''
echo ''
echo '====== Remove orphan packages ====='
echo ''

sudo pacman -Rns $(pacman -Qtdq)

echo ''
echo '====== Remove arch apps cache ====='
echo ''

rm -rf ~/.cache/*

echo "--removed"

echo '====== Remove Flatpak apps cache ====='
echo ''

rm -rf /var/lib/flatpak/repo/tmp/
rm -rf /var/tmp/flatpak-cache-*

echo "--removed"

echo '====== Remove pacman cache ======'
echo ''


sudo pacman -Scc

echo "--removed"

echo '====== Remove yaourt cache ======'
echo ''

rm -rf "/home/${USER}/.cache/yay"

echo "--removed"

echo '====== Remove Logs ====='
echo ''

sudo rm -rf /var/log/*

echo "--removed"

echo '====== Update mirror list ======'
echo ''

sudo reflector --country France,Germany --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "--updated"

echo '====== full update ======'
echo ''

sudo pacman -Syyuu

echo "--updated"

echo '====== flatpak update ======'
echo ''

sudo flatpak update

echo '====== END ======'
echo ''

echo "--Please, reboot your computer to avoid any problem"