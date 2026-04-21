# Secrets

Do not commit real secrets in this directory.

Encrypted files committed here:

- `sing-box-config.age`: real `~/.config/sing-box/config.json`
- `ssh-id_ed25519.age`: SSH private key
- `wifi.env.age`: optional Wi-Fi bootstrap credentials
- `cc-switch-db.age`: optional cc-switch runtime database
- `cc-switch-settings.age`: optional cc-switch settings
- `gh-hosts.age`: GitHub CLI host auth config for `~/.config/gh/hosts.yml`
- `recipients.txt`: public age recipient(s)

The private age identity is not committed. On this machine it was generated at:

```text
~/.config/age/arch-dots-key.txt
```

Back this file up offline. Without it, these secrets cannot be decrypted.

Example restore:

```sh
mkdir -p ~/.config/sing-box
age -d secrets/sing-box-config.age > ~/.config/sing-box/config.json
chmod 600 ~/.config/sing-box/config.json
```

Or use:

```sh
./scripts/25-restore-secrets.sh
```
