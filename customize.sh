# ZSH Installer for Android by rhythmcache.t.me
# github.com/rhythmcache

# Detect architecture
arch=$(getprop ro.product.cpu.abi)
ui_print "- Detected Architecture: $arch"

# Check for valid architecture
if [ ! -d "$MODPATH/zsh/$arch" ]; then
  abort "Error: Unsupported architecture"
fi

# Create directories
ui_print "- Creating directories"
mkdir -p "$MODPATH/system/bin"
mkdir -p "$MODPATH/system/usr/share"

# Copy binaries and configurations
ui_print "- Copying binaries"
cp "$MODPATH/zsh/$arch/zsh" "$MODPATH/system/bin" || abort "Failed to copy zsh binary"
cp -r "$MODPATH/zsh/$arch/terminfo" "$MODPATH/system/usr/share" || abort "Failed to copy terminfo"
cp "$MODPATH/zsh/.zshrc" "/data/local" || abort "Failed to copy .zshrc"

if [ -f "/system/etc/mkshrc" ]; then
  cp "/system/etc/mkshrc" "$MODPATH/system/etc" || abort "Failed to copy mkshrc"
  if ! grep -q "exec zsh" "$MODPATH/system/etc/mkshrc"; then
    echo "exec zsh" >> "$MODPATH/system/etc/mkshrc"
  else
    ui_print "- Warning:'exec zsh' already exists in mkshrc"
  fi
else
  ui_print "- Warning: /system/etc/mkshrc not found, skipping copy."
fi

rm -rf "$MODPATH/zsh"

# Setting permissions
ui_print "- Installing..."
ui_print "- Setting Permissions"
set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0755
set_perm_recursive "$MODPATH/system/usr" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/etc" 0 0 0755 0644

ui_print "- Installation complete"