{ pkgs, lib, ... }:

{
  nix.nixPath = [ 
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/miku/.dotfiles/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
}
