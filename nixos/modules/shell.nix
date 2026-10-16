{ config, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      gc = "nix-collect-garbage -d";
      clean = "sudo nix-collect-garbage -d";
      wfx = "net.waterfox.waterfox";
      ls = "ls";
      ll = "ls -la";
      update = "nh os switch -f $NH_FILE -- -I nixos-config=/etc/nixos/configuration.nix";
    };

    extraConfig = ''
      $env.config = {
        show_banner: false,
      }

      # Инициализация starship
      mkdir ~/.cache/starship
      starship init nu | save -f ~/.cache/starship/init.nu
      source ~/.cache/starship/init.nu
    '';
  };
}
