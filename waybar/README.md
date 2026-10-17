# Waybar Config

Custom configuration for [Waybar](https://github.com/Alexays/Waybar), a highly customizable Wayland bar for Sway and other wlroots-based compositors.

## Preview

![Waybar Preview](wbfix.png)

## Contents

- `config` - main configuration file (modules, layout, styling)
- `style.css` - visual styling (colors, fonts, spacing)
- Additional files may include custom scripts or module definitions

## Installation

1. Clone or copy this folder to your Waybar config directory:
   ```bash
   mkdir -p ~/.config/waybar
   cp -r ./* ~/.config/waybar/
2. Restart Waybar:
   ```bash
   killall waybar && waybar &

## Requirements

- Waybar (latest version recommended)

- Nerd Fonts (for icons), e.g. JetBrainsMono Nerd Font

- Any additional dependencies used by custom modules (check config)
