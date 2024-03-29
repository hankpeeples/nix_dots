# this file contains basic config i want to have on every device
{ pkgs, host, variables, ... }:
{
  # self-explaining one-liners
  console.keyMap = "us";
  time.timeZone = "America/Chicago";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = variables.version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = host.name;
    networkmanager.enable = true;
  };

  i18n.defaultLocale  = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_ADDRESS        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
  };

  ### user account and groups
  # create new group with username
  users.groups.${variables.username} = {};
  # create user
  users.users.${variables.username} = {
    isNormalUser = true;
    description = variables.username;
    extraGroups = [ # add user to groups (if they exist)
      variables.username
      "users"
      "wheel"
      "networkmanager"
    ];
  };

  ##########################################
  ##########################################
  ################ PACKAGES ################
  ##########################################
  ##########################################

  # packages to install, mostly command line stuff
  environment.systemPackages = with pkgs; [
    git
    zellij
    wget
    vim
    bash
    jq # process json
    lsd # better ls
    eza
    bat # better cat
    fzf # fast fuzzy finder
    tldr # summarize man pages
    zoxide # better cd
    fastfetch # neofetch but fast
    git-credential-manager
    gh
    lazygit
    neovim
    librespeed-cli # speedtest
    meson ninja # for building c/c++ projects
    pkg-config # for c/c++/rust dependency management
    starship # shell prompt, install as program and package to set PATH
    # compilers, interpreters, debuggers
    gcc
    rustup
    go
    nodePackages_latest.nodejs
    (python3.withPackages (python-pkgs: with python-pkgs; [
      virtualenv
    ]))
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  ###########################################
  ###########################################
  ########### PROGRAMS / SERVICES ###########
  ###########################################
  ###########################################

  # for secret storing stuff
  services.gnome.gnome-keyring.enable = true;

  # fix pkg-config by pointing it in the right way
  environment.sessionVariables.PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";

  ### fish shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "refined";
      plugins = [
        "git" "docker" "colored-man-pages"
      ];
    };
      
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };
  

  # config file location for starship prompt
  environment.sessionVariables.STARSHIP_CONFIG = "/etc/dotfiles/other/starship.toml";

  ############################################
  ############################################
  ############### HOME-MANAGER ###############
  ############################################
  ############################################
  # manage stuff in /home/$USER/
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${variables.username} = { config, ... }: {

  home.stateVersion = variables.version;
  # i dont know what this does?
  programs.home-manager.enable = true;

  ### create dotfiles
  # git config (mainly for credential stuff)
  home.file.".gitconfig".text = ''
    [user]
      name = ${variables.git.name}
      email = ${variables.git.email}
    [init]
      defaultBranch = main
    [credential]
      credentialStore = secretservice
      helper = ${pkgs.git-credential-manager}/bin/git-credential-manager
  '';

  ### symlink dotfiles
  # files in ~/.config/
  #xdg.configFile."fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/other/init.fish";
};}
