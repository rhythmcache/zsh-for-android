#zsh-for-android Installer by coldnw.t.me
# github.com/rhythmcache
ui_print "==================="
ui_print "ZSH for Android"
ui_print "=================="

# Detect architecture
arch=$(getprop ro.product.cpu.abi)
ui_print "> > Detected Architecture: $arch"

# Create directories
ui_print " > > Creating directories"
mkdir -p "$MODPATH/system/bin" || { ui_print "Failed to create $MODPATH/system/bin"; exit 1; }
mkdir -p "$MODPATH/system/etc" || { ui_print "Failed to create $MODPATH/system/etc"; exit 1; }
mkdir -p "$MODPATH/system/usr" || { ui_print "Failed to create $MODPATH/system/usr"; exit 1; }

# Copy binaries
ui_print " > > Copying binaries"
cp -r "$MODPATH/zsh/$arch"/* "$MODPATH/system/bin" || { ui_print "Failed to copy binaries for $arch"; exit 1; }
cp -r "$MODPATH/zsh/etc"/* "$MODPATH/system/etc" || { ui_print "Failed to copy etc files"; exit 1; }
cp -r "$MODPATH/zsh/usr"/* "$MODPATH/system/usr" || { ui_print "Failed to copy usr files"; exit 1; }
cp "$MODPATH/zsh/.zshrc" "/data/local" || { ui_print "Failed to copy .zshrc to /data/local"; exit 1; }
cp "/system/etc/mkshrc" "$MODPATH/system/etc"
echo "exec zsh" >> "$MODPATH/system/etc/mkshrc"
rm -r "$MODPATH/zsh"

# Setting permissions
ui_print " > > Installing..."
ui_print " > > Setting Permissions"
set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0777 || { ui_print "Failed to set permissions for $MODPATH/system/bin"; exit 1; }
set_perm_recursive "$MODPATH/system/usr" 0 0 0755 0644 || { ui_print "Failed to set permissions for $MODPATH/system/usr"; exit 1; }
set_perm_recursive "$MODPATH/system/etc" 0 0 0755 0644 || { ui_print "Failed to set permissions for $MODPATH/system/etc"; exit 1; }

ui_print "> > Installation complete"
ui_print "> > Make sure ncurses is installed"
ui_print "[*] Done!"
ui_print ""
