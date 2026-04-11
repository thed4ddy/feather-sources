# Feather Sources

Unofficial AltStore/Feather source for sideloading apps. Auto-updated every 6 hours via GitHub Actions.

## Plezy — Modern Plex Client

A modern Plex client built with Flutter — native performance, clean UI, stream your entire media library.

[![Add to Feather](https://img.shields.io/badge/Add_to_Feather-6C63FF?style=for-the-badge&logo=apple&logoColor=white)](https://intradeus.github.io/http-protocol-redirector?r=feather://source/https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json)
[![Add to AltStore](https://img.shields.io/badge/Add_to_AltStore-000000?style=for-the-badge&logo=apple&logoColor=white)](https://intradeus.github.io/http-protocol-redirector?r=altstore://source?url=https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json)

**Manual source URL:**
```
https://raw.githubusercontent.com/thed4ddy/feather-sources/main/apps.json
```

## How It Works

A [scheduled workflow](.github/workflows/update-plezy.yml) checks [edde746/plezy](https://github.com/edde746/plezy) releases every 6 hours. When a new version is found, `apps.json` is automatically updated with the latest IPA download link, version info, and changelog.

## Disclaimer

This is an unofficial source. All app rights belong to their respective developers.
