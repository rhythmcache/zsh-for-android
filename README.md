# zsh-for-android

- Magisk module for systemless integration of zsh in Android, enhancing your terminal experience 
---
## Installation
- Flash these two modules in `Magisk` , `KernelSU` or `Apatch`
- [ncurses-for-android](https://github.com/rhythmcache/zsh-for-android/releases/download/V1/ncursesw-for-android.zip)
- [zsh-for-android](https://github.com/rhythmcache/zsh-for-android/releases/download/V1/zsh-for-android.zip)
- Installation may take some time
- Reboot your device after installation is complete।
---
## Zshrc
- custom `.zshrc` can be loaded from internal storage at `/data/local/.zshrc`
- The module includes a **pre-configured `.zshrc`** by default, which gets copied to your internal storage during installation. You can edit this file to add your own custom logic or terminal customizations
---
- Default Interface
```
╭─system@peux in /
╰─❯❯❯$ su                                                   
╭─root@peux in /
╰─❯❯❯#
```
(peux) will be replaced by your device codename
##### Termux
- `Termux`  uses its own shell environment that is independent of the default Android shell. if you use termux and you want to make these changes apply also in `Termux` you'll need to make additional changes for it to apply within Termux.
- Run this command in `termux`
```
pkg install zsh -y
curl -o ~/.zshrc https://raw.githubusercontent.com/rhythmcache/zsh-for-android/main/zsh/.zshrc
chsh -s zsh
exit
```
---
## Credits

- [@zackptg5](https://github.com/Zackptg5) for `ncurses` and `zsh` cross compiled binaries
- [@topjohnwu](https://github.com/topjohnwu) - Magisk Developer

  ---
  [![Telegram](https://img.shields.io/badge/Telegram-Join%20Chat-blue?style=flat-square&logo=telegram)](https://t.me/ximistuffschat)
  ![Downloads](https://img.shields.io/github/downloads/rhythmcache/zsh-for-android/total.svg)



