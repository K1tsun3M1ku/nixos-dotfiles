# NOTE: nixos stuff
sudo ln -s $HOME/.dotfiles/configuration-append.nix /etc/nixos/configuration-append.nix
sudo ln -s $HOME/.dotfiles/flake.lock /etc/nixos/flake.lock
sudo ln -s $HOME/.dotfiles/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s $HOME/.dotfiles/secrets.nix /etc/nixos/secrets.nix
sudo ln -s $HOME/.dotfiles/configuration.nix /etc/nixos/configuration.nix
sudo ln -s $HOME/.dotfiles/flake.nix /etc/nixos/flake.nix
sudo ln -s $HOME/.dotfiles/home.nix /etc/nixos/home.nix

# NOTE: homemanager
ln -s $home/.dotfiles/nixos/home-manager $home/.config/home-manager

