# config variables that are shared by all of my devices.
{ callPackage }:
{
  # nixos and home-manager state version
  version = "23.11";
  # username and displayname of only user
  username = "notroot";
  displayname = "NotRoot";
  # global git config
  git.name = "Henry Peeples";
  git.email = "hgpeeples48@gmail.com";
  # nixos configurations for different devices
  nixosConfigs = { mkNixosConfig, inputs }: {
    # "desktop" will be built by default
    desktop = mkNixosConfig {
      # networking hostname
      hostName = "nixos-2";
      # firefox profile to customize
      firefoxProfile = "h5hep79f.dev-edition-default";
      # nix configuration to include
      modules = [
        ./base/desktop.nix
        ./hosts/desktop
      ];
    };
  };
  # include other expressions
  secrets = import ./secrets.nix;
  pkgs = callPackage (import ./pkgs) {};
}
