# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/nvidia.nix
    ./modules/packages.nix
    ./modules/system.nix
    ./modules/user.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  networking.wireless.iwd.settings = {
    General = {
      Country = "RU";
      EnableNetworkConfiguration = false;
    };
    Settings = {
      AutoConnect = false;
    };
  };
  networking.nameservers = [ 
    "1.1.1.1"                  # Cloudflare (Основной быстрый)
    "8.8.8.8"                  # Google (Резервный стабильный)
    "2606:4700:4700::1111"     # Cloudflare IPv6
    "2001:4860:4860::8888"     # Google IPv6
  ];
  hardware.firmware = [
    (pkgs.runCommand "mt7925-firmware" { } ''
      mkdir -p $out/lib/firmware/mediatek
      # Здесь можно было бы скачать прошивку из официального репозитория kernel.org, 
      # если она отсутствует в системном пакете
    '')
  ];
  nixpkgs.overlays = [
    (self: super: {
      nixos-rebuild = super.nixos-rebuild.override {
        nix = super.nix-monitored;
      };
    })
  ];
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  console = {
    font = "cyr-sun16"; # Этот шрифт поддерживает кириллицу в консоли
    keyMap = "ru"; # Чтобы можно было вводить пароль/логин на русском, если надо
    earlySetup = true; # Загружаем шрифт сразу при старте ядра
  };

  services.flatpak.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment?
}
