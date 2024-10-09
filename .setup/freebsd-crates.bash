if [ $(id -nu) == "root" ]; then
	echo "don't run as root these are installed for user";
	exit
fi

CARGOS=( ripgrep skim typst-cli atuin just exa broot nu starship )
export PATH=$PATH:~/.cargo/bin
for crate in "${CARGOS[@]}"; do
	echo "🦀 $crate";
	command -v $crate || cargo install $crate
done

