# sing-box migration notes

This directory contains a first-pass sing-box client config generated from the
current Sparkle/Mihomo setup on this machine.

What it already does:

- keeps the current VLESS Reality node
- exposes a local mixed proxy on `127.0.0.1:7890`
- enables `set_system_proxy`
- enables Linux TUN with `auto_route` and `auto_redirect`
- keeps selector-style groups so you can choose `direct` or `proxy`
- blocks ad domains through route rules
- exposes Clash API on `127.0.0.1:9090` for selector control

What it does not try to do:

- one-to-one convert every single Mihomo rule in the current Sparkle profile
- replace Sparkle before sing-box is confirmed working

Recommended install on Arch:

```bash
paru -S --needed sing-box-bin
```

Check and format before enabling:

```bash
sing-box check -c ~/.config/sing-box/config.json
sing-box format -w -c ~/.config/sing-box/config.json
```

Quick manual test:

```bash
sudo sing-box run -c ~/.config/sing-box/config.json
```

Or use the helper script:

```bash
~/.local/bin/sing-box-manage check
~/.local/bin/sing-box-manage format
~/.local/bin/sing-box-manage test
```

If manual test is good, install as a system service:

```bash
sudo install -Dm600 ~/.config/sing-box/config.json /etc/sing-box/config.json
sudo systemctl enable --now sing-box
```

Or use the helper script:

```bash
~/.local/bin/sing-box-manage install
~/.local/bin/sing-box-manage enable
```

Important:

- stop Sparkle system proxy and TUN before starting sing-box, or they will fight
- TUN and system proxy changes require root-run sing-box on Linux
- selector switching is done through Clash API compatible UIs

Controller options:

- remote UI: `https://metacubex.github.io/?hostname=127.0.0.1&port=9090&secret=REPLACE_ME`
- or any other Clash API compatible dashboard

Typical migration order:

1. Disable Sparkle `sysProxy` and `tun`.
2. Run `sudo sing-box run -c ~/.config/sing-box/config.json`.
3. Open the Clash API UI and pick selectors such as `proxy`, `cn`, `final`.
4. If routing is correct, move the config to `/etc/sing-box/config.json`.

Files referenced from the old setup:

- Sparkle app config: `~/.config/sparkle/config.yaml`
- current generated Mihomo config: `~/.config/sparkle/work/config.yaml`
