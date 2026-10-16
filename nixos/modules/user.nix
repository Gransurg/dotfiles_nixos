{ config, pkgs, ... }:
{
  services.getty.autologinUser = "mockingbird";
  users.defaultUserShell = pkgs.nushell;
  users.users.mockingbird = {
    isNormalUser = true;
    shell = pkgs.nushell;
    description = "mockingbird";
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "scanner"
      "render"
      "video"
    ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };
}
