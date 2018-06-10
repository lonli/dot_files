export XIM=fcitx
export XMODIFIERS="@im=fcitx"
export XIM_PROGRAM=fcitx
export QT_IM_MODULE=fcitx

xscreensaver -no-splash &
# mlnet &
goldendict &
fcitx
xrdb -merge ~/.Xresources

# xset -b
# xkbset exp =m
# xkbset m ma 60 10 10 5 2

setxkbmap -layout us,us -variant ,dvp \
    -option 'lv3:ralt_alt' \
    -option 'grp:sclk_toggle' \
    -option 'grp_led:scroll' \
    -option 'caps:escape' \
    -option 'compose:menu' \
    -option 'numpad:microsoft' \
    -option 'terminate:ctrl_alt_bksp'
xmodmap ~/.Xmodmap
xbindkeys
wmname LG3D
~/bin/ch.sh &

function run_dwm {
    while xsetroot -name "`date +'%a   %F %R'`   `free | grep 'Mem' | awk '{print int((100*$3)/$2) \"%\"}'`"
    do
        sleep 5
    done &
    feh --bg-fill ~/Pictures/arch_02.jpg
    exec dwm
}

function run_awesome {
    exec awesome
}

function run_lxde {
    exec startlxde
}

function run_enligtenment {
    exec enlightenment_start
}

session=${1:-dwm}

case $session in
    awe ) run_awesome ;;
    en ) run_enligtenment ;;
    lxde ) run_lxde ;;
    * ) run_dwm ;;
esac
