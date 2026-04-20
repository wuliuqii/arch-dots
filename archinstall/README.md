# archinstall

Keep Arch installation JSON files here.

Recommended usage from the Arch ISO:

```sh
archinstall --config user_configuration.json --creds user_credentials.json
```

Generate these files interactively on a known-good install first:

```sh
archinstall --dry-run
```

Then save and review the generated JSON. Do not commit real credentials.

This repository does not fork `archinstall`; it only stores reusable input
configuration. Post-install desktop setup belongs in `bootstrap/`, `packages/`,
`chezmoi/`, `system/`, and `scripts/`.

