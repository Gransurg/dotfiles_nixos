{ config, pkgs, ... }:
{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";

    wifi.scanRandMacAddress = false;
    wifi.powersave = false;

    # settings = {
    #   main = {
    #     ip4-config-method = "auto";
    #   };
    #   # В INI-файле NetworkManager это секция [device] с ключом wifi.scan-always
    #   # Либо отдельная секция [device-wifi]
    #   "device" = {
    #     "wifi.scan-always" = "yes"; # В INI-формате лучше передавать строкой "yes" или "true"
    #   };
    # };
  };
    
  # networking.wireless = {
  #   enable = false;
  #   userControlled.enable = true;
  # };
  networking.wireless.iwd = {
     enable = true;
   };
  # networking.wireless.enable = false;
  hardware.bluetooth.enable = true;

  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  services.blueman.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.xkb = {
    layout = "ru, us";
    variant = "";

  };

  services.printing = {
    enable = true;
    drivers = [
      (pkgs.symlinkJoin {
        name = "samsung-splix-combined";
        paths = [
          pkgs.splix
          pkgs.cups-filters
        ];
      })
    ];
  };

  hardware.printers.ensurePrinters = [ ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
