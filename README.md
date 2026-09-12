<div align="center">
  <img src="assets/manifesthub.png" alt="Manifest Hub Logo" width="150"/>
  <h1>Manifest Hub</h1>
  <p><b>Web Application for Searching, Viewing, and Downloading Steam Manifests</b></p>
  <p>
    <img src="https://img.shields.io/badge/JavaScript-ES6%2B-F7DF1E?logo=javascript&logoColor=black" alt="JavaScript">
    <img src="https://img.shields.io/badge/Platform-Web%20%7C%20PWA-blue" alt="Platform">
    <img src="https://img.shields.io/badge/License-GPL--3.0-amber" alt="License">
  </p>
  <p>
    <a href="https://manifesthub.trionine.com"><b>🌐 Live Website</b></a> •
    <a href="https://github.com/sadabx/TOST"><b>🎮 TOST Desktop Companion</b></a>
  </p>
</div>

## Index

1. [What is Manifest Hub?](#what-is-manifest-hub)
2. [Features](#features)
3. [Getting Started](#getting-started)
4. [Screenshots](#screenshots)
5. [Data Sources](#data-sources)
6. [Support](#support)
7. [Credits](#credits)

## What is Manifest Hub?

**Manifest Hub** is a lightweight, responsive web application for searching and downloading Steam game manifests, depot keys, and ready-to-use Lua injection scripts for SteamTools.

Instead of scouring forums or dealing with dead links, Manifest Hub provides an all-in-one search catalog and download engine that pairs directly with **[TOST (Trionine Open Steam Tool)](https://github.com/sadabx/TOST)** and SteamTools.

## Features

### Core Search & Downloads
- **Instant Search**: Search across 150,000+ Steam games, DLCs, and software with instant autocomplete.
- **86,500+ Lua Scripts**: Pre-configured scripts with verified depot keys and DLC unlocks powered by KeySteam.
- **Live Manifests**: Queries SteamCMD dynamically to fetch the latest public manifest GIDs in real time.
- **ZIP Bundling**: Download individual `.manifest` / `.lua` files or click **Download All** for a single ZIP.
- **Archive Fallbacks**: Automatic fallback to comprehensive manifest archives ([ManifestHub3](https://github.com/steamtools-games/ManifestHub3) & [ManifestHub2](https://github.com/SSMGAlt/ManifestHub2)).

### User Features
- **Personal History**: Optional account sync to keep track of your downloaded games.
- **Community Forum & Polls**: Built-in discussion forum and voting polls.
- **Fast & Private**: 100% client-side file resolution with no ads or bloatware.

## Getting Started

### Basic Usage
1. Open **[Manifest Hub](https://manifesthub.trionine.com)**.
2. Search for any game name or Steam App ID.
3. Choose your file:
   - **Lua Keys**: Pre-configured SteamTools injection script.
   - **Manifest Files**: The official `.manifest` file for each depot.
   - **Legacy Zip**: Full bundled archive from the manifest cache.
4. Click **Download** or **Download All**.
5. Drag and drop the downloaded files directly onto the floating **[TOST](https://github.com/sadabx/TOST)** icon or your SteamTools folder.
6. Right-click the icon and choose **Apply OST** (Windows) or **Apply SLSsteam** (Linux) to activate.

## Screenshots

<details>
<summary>Click to expand screenshots</summary>

### Homepage & Search
![Homepage](assets/screenshots/Screenshot_20260623_153129.png)

### Game Details & File Panel
![Search Results](assets/screenshots/Screenshot_20260623_153230.png)

### Legacy Archive Terminal
![Legacy Archive](assets/screenshots/Screenshot_20260623_153309.png)

### User Download History
![User Download History](assets/screenshots/Screenshot_20260623_202028.png)

### User Account Controls
![User Account Controls](assets/screenshots/Screenshot_20260623_201936.png)

</details>

## Data Sources

- **[bsinwhg/ManifestHubLua](https://github.com/bsinwhg/ManifestHubLua)**: KeySteam Lua database providing verified `.lua` scripts for 86,500+ games.
- **[steamtools-games/ManifestHub3](https://github.com/steamtools-games/ManifestHub3)**: Primary manifest archive repository powering `steamtools.games`.
- **[SSMGAlt/ManifestHub2](https://github.com/SSMGAlt/ManifestHub2)**: Secondary legacy archive repository fallback.
- **[jsnli/steamappidlist](https://github.com/jsnli/steamappidlist)**: Master catalog mapping game names to Steam App IDs.
- **[api.steamcmd.net](https://api.steamcmd.net/)**: Live depot metadata and latest manifest IDs.
- **[qwe213312/k25FCdfEOoEJ42S6](https://github.com/qwe213312/k25FCdfEOoEJ42S6)**: Public manifest file storage.

## Support

Bug reports and feature suggestions can be submitted via the [GitHub Issue Tracker](https://github.com/trionine/ManifestHub/issues).

## Credits

### Contributors
- Developed and maintained by **[TRIONINE](https://trionine.com)**.

### Upstream & Community
- **[TOST](https://github.com/sadabx/TOST)**: Trionine Open Steam Tool companion desktop manager.
- **KeySteam**: Lua key database maintained by *o四季映姬o*.
- **SteamTools**: Open community manifest and Lua specifications.

### Disclaimer
This project is provided for research and educational purposes only. Manifest Hub is an independent open-source web application and is not affiliated with, maintained, or endorsed by Valve, Steam, or SteamTools.

---

Distributed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for details.
