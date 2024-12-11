ui_print "==================="
ui_print "ZSH for Android"
ui_print "=================="

# Detect architecture
arch=$(getprop ro.product.cpu.abi)
ui_print "Detected architecture: $arch"

# Create directories
ui_print "Creating directories"
mkdir -p "$MODPATH/system/bin" || { ui_print "Failed to create $MODPATH/system/bin"; exit 1; }
mkdir -p "$MODPATH/system/etc" || { ui_print "Failed to create $MODPATH/system/etc"; exit 1; }
mkdir -p "$MODPATH/system/usr" || { ui_print "Failed to create $MODPATH/system/usr"; exit 1; }

# Copy binaries
ui_print "Copying binaries"
cp -r "$MODPATH/zsh/$arch"/* "$MODPATH/system/bin" || { ui_print "Failed to copy binaries for $arch"; exit 1; }
cp -r "$MODPATH/zsh/etc"/* "$MODPATH/system/etc" || { ui_print "Failed to copy etc files"; exit 1; }
cp -r "$MODPATH/zsh/usr"/* "$MODPATH/system/usr" || { ui_print "Failed to copy usr files"; exit 1; }
cp "$MODPATH/zsh/.zshrc" "/sdcard" || { ui_print "Failed to copy .zshrc to /sdcard"; exit 1; }
cp "/system/etc/mkshrc" "$MODPATH/system/etc"
echo "exec zsh" >> "$MODPATH/system/etc/mkshrc"
cp "$MODPATH/module.prop" "$MODPATH" || { ui_print "Failed to copy module.prop"; exit 1; }

# Setting permissions
ui_print "Installing..."
ui_print ""
set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0755 || { ui_print "Failed to set permissions for $MODPATH/system/bin"; exit 1; }
set_perm_recursive "$MODPATH/system/usr" 0 0 0755 0644 || { ui_print "Failed to set permissions for $MODPATH/system/usr"; exit 1; }
set_perm_recursive "$MODPATH/system/etc" 0 0 0755 0644 || { ui_print "Failed to set permissions for $MODPATH/system/etc"; exit 1; }

ui_print " [*] Done!"
ui_print ""
