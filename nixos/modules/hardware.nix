{ config, pkgs, ... }:

{
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    gfxmodeEfi = "1920x1080";
    timeoutStyle = "menu";
    useOSProber = true; 

    theme = pkgs.stdenv.mkDerivation {
      pname = "grubphemous-theme";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "pvtoari";
        repo = "grubphemous-theme";
        rev = "master";
        hash = "sha256-9BPKNL7k2nePB1GvJ3MS/BqgcYddbY+Rw3vlxdjGyn0=";
      };
    installPhase = ''
      mkdir -p $out
      cp -r grubphemous/* $out/    
    '';
  };
};
  # Use stable kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;  

  boot.extraModulePackages = [
    # config.boot.kernelPackages.zenpower
    config.boot.kernelPackages.lenovo-legion-module
  ];

  boot.blacklistedKernelModules = [ "nouveau" ];

  boot.kernelModules = [
    # "zenpower"
    "lenovo-legion-module"
    "k10temp"
    "mt7925e"
    "iwlwifiу"
  ];

  boot.extraModprobeConfig = ''
    options mt7925e disable_aspm=1
  '';

  boot.kernelParams = [
    "clearcpuid=514"
    "nvidia_drm.fbdev=1"
    "i2c-dev"
    "acpi_enforce_resources=lax"
    "amd_pstate=active"
    "msr.allow_writes=on"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "iommu=soft"
  ];

  hardware.i2c.enable = true;
  hardware.enableAllFirmware = true;
  hardware.xpadneo.enable = true;

  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];

  services.power-profiles-daemon.enable = true;

  zramSwap.enable = true;
  zramSwap.priority = 100;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8192;
      priority = 10;
    }
  ];
}
