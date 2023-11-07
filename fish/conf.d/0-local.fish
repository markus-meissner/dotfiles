#echo 'LOAD "0-local.fish",8,1'

# https://github.com/jethrokuan/z/issues/104
set Z_DATA_DIR "$HOME/.local/share/z"
set Z_DATA "$Z_DATA_DIR/data"
set Z_EXCLUDE "^$HOME\$"

tide_detect_os | read -g --line os_branding_icon os_branding_color os_branding_bg_color os_branding_version

