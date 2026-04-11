# Feather Sources

Unofficial [AltStore](https://altstore.io)/[Feather](https://github.com/khcrysalis/Feather) source for sideloading apps — auto-updated every 6 hours.

[![Add to Feather](https://img.shields.io/badge/Add_to_Feather-6C63FF?style=for-the-badge&logo=apple&logoColor=white)](https://intradeus.github.io/http-protocol-redirector?r=feather://source/https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json)
[![Add to AltStore](https://img.shields.io/badge/Add_to_AltStore-000000?style=for-the-badge&logo=apple&logoColor=white)](https://intradeus.github.io/http-protocol-redirector?r=altstore://source?url=https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json)

**Manual source URL:**
```
https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json
```

---

## Apps

| App | Description | Upstream |
|-----|-------------|----------|
| **Plezy** | Modern Plex client built with Flutter — clean UI, native performance | [edde746/plezy](https://github.com/edde746/plezy) |

## How it works

A [GitHub Actions workflow](.github/workflows/update-plezy.yml) runs every 6 hours, checks for new releases from upstream repos, and updates `apps.json` with the latest IPA download link, version, and changelog.

## Disclaimer

Unofficial source — all app rights belong to their respective developers.
