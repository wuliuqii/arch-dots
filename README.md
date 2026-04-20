# arch-dots

Arch Linux desktop bootstrap and dotfiles for a niri-based workstation.

This repository intentionally separates responsibilities:

- `archinstall/`: optional Arch install JSON files.
- `bootstrap/`: first-boot helpers, including proxy bootstrap before AUR.
- `packages/`: pacman and AUR package lists.
- `chezmoi/`: user dotfiles managed by chezmoi.
- `system/`: source files intended for `/etc`.
- `scripts/`: repeatable install/apply/verify scripts.
- `secrets/`: encrypted or out-of-band secrets only.

## Fresh Machine Flow

1. Install a base Arch system with `archinstall` or manual install.
2. Clone this repo to `~/src/arch-dots`.
3. If network access to AUR/GitHub is blocked, start the bootstrap proxy.
4. Install `paru`.
5. Install packages from `packages/`.
6. Apply dotfiles with chezmoi.
7. Install system configs and enable services.

Typical sequence after first boot:

```sh
cd ~/src/arch-dots
./bootstrap/scripts/00-network.sh
./bootstrap/scripts/01-start-bootstrap-proxy.sh
./bootstrap/scripts/02-install-paru.sh
./scripts/10-install-packages.sh
./scripts/20-apply-dotfiles.sh
./scripts/25-restore-secrets.sh
./scripts/30-install-system.sh
./scripts/40-enable-services.sh
./scripts/90-post-check.sh
```

## Chezmoi

This repo uses `~/src/arch-dots/chezmoi` as the chezmoi source directory.

Initialize on a new machine:

```sh
chezmoi init --source ~/src/arch-dots/chezmoi --apply
```

Daily workflow:

```sh
nvim ~/src/arch-dots/chezmoi/dot_config/niri/config.kdl
chezmoi diff
chezmoi apply
git status
git add .
git commit -m "Update niri config"
```

If you edit a live file first:

```sh
chezmoi re-add ~/.config/niri/config.kdl
chezmoi diff
```

## Proxy Bootstrap

Do not assume AUR/GitHub is reachable on a fresh machine.

Put an offline `sing-box` binary and `config.bootstrap.json` in:

```text
bootstrap/proxy/sing-box
bootstrap/proxy/config.bootstrap.json
```

These files are ignored by git by default. Store them on USB or force-add them
only in a private repository.

The bootstrap config should be minimal: one usable node, `mixed` inbound on
`127.0.0.1:7890`, no remote rule sets.

## Secrets

Do not commit real node configs, SSH private keys, Wi-Fi passwords, or tokens.
Use `age` or `sops` and decrypt during bootstrap.

This repo expects the private age identity at:

```text
~/.config/age/arch-dots-key.txt
```

Override with:

```sh
ARCH_DOTS_AGE_IDENTITY=/path/to/key.txt ./scripts/25-restore-secrets.sh
```

The real sing-box config should eventually be installed to:

```text
/etc/sing-box/config.json
```

The user-side config lives at:

```text
~/.config/sing-box/config.json
```

## Current Desktop Stack

- niri + DMS/quickshell
- foot
- fish + zoxide + starship
- neovim/LazyVim
- btop with Catppuccin light/dark themes
- OpenAI Codex and cc-switch helpers
- fcitx5 + rime-ice
- Catppuccin GTK/Qt/Fcitx/cursor/icon stack
- sing-box system service with TUN
- WeChat direct launcher wrapper
- Tencent Meeting wrapper with bwrap writable cache fixes
