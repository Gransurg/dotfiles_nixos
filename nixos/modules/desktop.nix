{ config, pkgs, ... }:

{
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "CommitMono Nerd Font Mono"
          "FiraCode Nerd Font Mono"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif"
          "DejaVu Serif"
        ];
      };
    };

    #  пакеты шрифтов
    packages = with pkgs; [
      # Основные шрифты
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      dejavu_fonts
      ipafont
      kochi-substitute
      # Монопространственные шрифты с программистскими лигатурами
      fira-code
      fira-code-symbols

      # Японские шрифты
      mplus-outline-fonts.githubRelease

      # Простые моноширинные шрифты
      dina-font
      proggyfonts

      nerd-fonts.commit-mono # CommitMono Nerd Font
      nerd-fonts.fira-code # FiraCode Nerd Font
      nerd-fonts.fira-code # FiraCode Nerd Font
      nerd-fonts.jetbrains-mono # JetBrainsMono Nerd Font
      nerd-fonts.droid-sans-mono # DroidSansMono Nerd Font
    ];
  };

  environment.variables = {
    # Подсказывает приложениям использовать Wayland
    NIXOS_OZONE_WL = "1";
    __GL_MaxFramesAllowed = "1";
    # Рендеринг через NVIDIA
    # LIBVA_DRIVER_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Исправляет возможные моргания курсора в niri
    WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_SCENE_DISABLE_DIRECT_SCANOUT = "1";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
    # Геймерское чудо-юдо
    # __VK_LAYER_NV_optimus = "NVIDIA_only";
    # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    NVD_BACKEND = "direct";
  };
  environment.variables = {
    NH_FILE = "<nixpkgs/nixos>";
    NH_ATTRP = "nixos";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ]; # Нужен для диалогов открытия файлов
    config.common.default = [
      "gnome"
      "gtk"
    ];
  };
}
