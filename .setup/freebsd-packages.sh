if [ $(id -nu) != "root" ]; then
	echo "su before running freebsd.sh";
	exit
fi

PKGS=( couchdb3 go fzf inkscape zathura zathura-pdf zathura-cb zathura-djvu sbcl zig syncthing drm-kmod cmake git neovim tmux rust victor-mono-ttf lagrange chromium firefox zoxide kakoune sway swayidle swaylock-effects alacritty kitty dmenu-wayland dmenu wmenu )

for pkg in "${PKGS[@]}"; do
	echo "*** $pkg";
	command -v $pkg || pkg install -y $pkg
done

pw groupmod video -m sjanes
sysrc kld_list+=i915kms
