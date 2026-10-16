{ config, pkgs, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "srinivasr";
    repo = "nirimod";
    rev = "7a449c8451bd171d3c1d4281afc61f9d9f3ed86d";
    sha256 = "sha256-taHvAqDjemBHzFYCXjAVD2xZbIdsQxcXXlPq6Ebbio4=";
  };

  nirimod = pkgs.callPackage (src + "/package.nix") {};
in
{
  environment.systemPackages = with pkgs; [
    git
    neovim
    nh
    telegram-desktop
    starship
    vesktop
    nushell
    thunar
    zsh-autosuggestions
    zsh-syntax-highlighting
    curl
    waybar
    # swaybg
    swayosd
    swaynotificationcenter
    awww
    bat
    wl-clipboard
    xwayland
    btop
    baobab
    bleachbit
    fastfetch
    libreoffice-qt
    vlc
    unar
    i7z
    waypaper
    yazi
    xwayland-satellite
    brightnessctl
    wireplumber
    gparted
    lm_sensors
    bluez
    bluez5
    bluetuith # TUI для bluetooth
    networkmanager # nmcli
    pipewire # для pipewire-pulse
    fzf
    wf-recorder
    networkmanagerapplet
    aria2
    kitty
    clang
    clang-tools
    unzip
    rofi
    heroic
    tree-sitter
    wineWowPackages.staging
    winetricks
    protontricks
    # linuxKernel.packages.linux_6_19.cpupower
    pciutils
    ripgrep
    glib # дает команду 'gio', которую ищет Snacks для удаления в корзину
    sqlite # чтобы работала "Frecency" (частота использования файлов)
    lazygit
    gcc
    tree-sitter
    lua-language-server
    sqlite
    zls
    nil
    llvmPackages_18.lldb # Содержит lldb-dap
    gdb
    tree
    ruff
    zathura
    egl-wayland
    dig
    gamescope
    nirimod
    foliate
    adwaita-icon-theme
    nwg-look
    flat-remix-icon-theme
    bibata-cursors
    capitaine-cursors
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  # programs.coolercontrol.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extest.enable = true;
  };

  programs.gamemode.enable = true;
  programs.dconf.enable = true;
  # programs.foliate.enable = true;
}
