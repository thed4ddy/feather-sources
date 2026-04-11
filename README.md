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

A [GitHub Actions workflow](.github/workflows/update-apps.yml) runs every 6 hours, iterates over every app config in [`apps/`](apps/), checks for new GitHub releases, and updates `apps.json` with the latest IPA download links, versions, and changelogs.

## Adding a new app

1. Create a JSON config in `apps/` (e.g. `apps/myapp.json`):

```json
{
  "name": "My App",
  "bundleIdentifier": "com.example.myapp",
  "developerName": "developer",
  "subtitle": "Short description",
  "localizedDescription": "Longer description of the app.",
  "iconURL": "https://example.com/icon.png",
  "tintColor": "#FF6600",
  "source": {
    "repo": "owner/repo",
    "asset": "myapp.ipa"
  }
}
```

2. Push to `main` — the next workflow run will pick it up automatically and add the app to `apps.json`.

**Config fields:**

| Field | Description |
|-------|-------------|
| `name` | Display name in Feather/AltStore |
| `bundleIdentifier` | iOS bundle ID |
| `developerName` | Developer or org name |
| `subtitle` | One-liner shown in the source |
| `localizedDescription` | Full description |
| `iconURL` | URL to the app icon |
| `tintColor` | Hex color for the source UI |
| `source.repo` | GitHub `owner/repo` to watch for releases |
| `source.asset` | Filename of the IPA asset in the release |

## Disclaimer

Unofficial source — all app rights belong to their respective developers.
