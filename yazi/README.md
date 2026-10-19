
# Yazi Config

Custom configuration for [Rofi](https://github.com/davatorium/rofi), a window switcher, application launcher and dmenu replacement.

## Preview

![Rofi Preview](rofi.png)

## Contents

- `config.rasi` - main configuration file (theme, layout, colors)
- Additional theme files or scripts may be present

## Usage with Niri

This configuration is designed to work with the [Niri](https://github.com/YaLTeR/niri) scrollable-tiling Wayland compositor.

The keybinding `Alt + O` is mapped in the Niri configuration to launch Rofi as an application launcher.

## Installation

1. Clone or copy this folder to your Rofi config directory:
   ```bash
   mkdir -p ~/.config/rofi
   cp -r ./* ~/.config/rofi/
2. Launch Rofi to test:
    ```bash
    rofi -show drun

## Requirements
- Rofi (latest version recommended)

- Niri compositor

- Nerd Fonts (for icons), e.g. JetBrainsMono Nerd Font
