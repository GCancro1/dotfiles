CONFIG_DIR="$HOME/.config/kitty"
CONFIG_FILE="$CONFIG_DIR/kitty.conf"
THEME_FILE="$CONFIG_DIR/theme.conf"

echo "Creating Kitty configuration directory..."
mkdir -p "$CONFIG_DIR"

# 1. Generate the Tokyo Night color theme file
echo "Writing Tokyo Night theme configuration..."
cat << 'EOF' > "$THEME_FILE"
# Tokyo Night color scheme for kitty
foreground            #a9b1d6
background            #1a1b26
selection_foreground  none
selection_background  #28344a
url_color             #9ece6a
cursor                #c0caf5
cursor_text_color     #1a1b26

# Colors
color0  #414868
color8  #414868
color1  #f7768e
color9  #f7768e
color2  #73daca
color10 #73daca
color3  #e0af68
color11 #e0af68
color4  #7aa2f7
color12 #7aa2f7
color5  #bb9af7
color13 #bb9af7
color6  #7dcfff
color14 #7dcfff
color7  #c0caf5
color15 #c0caf5
EOF

# Backup existing config if it exists
if [ -f "$CONFIG_FILE" ]; then
    echo "Backing up existing kitty.conf to kitty.conf.bak..."
    mv "$CONFIG_FILE" "$CONFIG_FILE.bak"
fi

# Write optimal default configurations
echo "Writing default configurations..."
cat << 'EOF' > "$CONFIG_FILE"
# --- Font Configuration ---
font_family      JetBrainsMono Nerd Font
font_size        14.0

# --- Theme Link ---
include theme.conf

# --- Window Customization ---
window_padding_width 8
background_opacity 0.90
dynamic_background_opacity yes

# --- Terminal Bell ---
enable_audio_bell no

# --- Scrollback ---
scrollback_lines 10000

# --- Keybindings ---
# Reload configuration dynamically
map ctrl+shift+f5 load_config_file
EOF

echo "Kitty configuration successfully created!"
