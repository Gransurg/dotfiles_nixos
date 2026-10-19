# Rofi Config

Custom configuration for [Rofi](https://github.com/sxyazi/yazi), fast terminal file manager written in Rust, based on async I/O.

## Preview

![Yazi Preview](yazi_sc.png)

## Contents

- `flavor.toml` - main configuration file (theme, layout, colors)

## Usage with Niri

This configuration is designed to work with the [Niri](https://github.com/YaLTeR/niri) scrollable-tiling Wayland compositor.

The keybinding `Alt + Y` is mapped in the Niri configuration to launch Yazi.

## Installation

1. Clone or copy this folder to your Rofi config directory:
   ```bash
   mkdir -p ~/.config/yazi
   cp -r ./* ~/.config/yazi/
2. Launch Yazi to test:
    ```bash
    yazi

## Requirements
- Yazi (latest version recommended)

- Niri compositor

