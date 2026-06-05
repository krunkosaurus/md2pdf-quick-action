# md2pdf-quick-action

Right-click any Markdown file in macOS Finder → **Quick Actions → Make PDF** → get a nicely formatted PDF that opens automatically in Preview.

Also installs a tiny `m` command so you can do the same from the terminal:

```bash
m notes.md            # creates notes.pdf and opens it
m a.md b.md c.md      # works on multiple files
```

## How it works

- **`bin/m`** — a small bash wrapper around [`md-to-pdf`](https://github.com/simonhaenisch/md-to-pdf) (Node + headless Chromium) that:
  - converts `file.md` → `file.pdf` next to the original
  - strips the `com.apple.quarantine` xattr from the output (without this, PDFs generated from a Finder Quick Action get quarantined and Preview fails with a misleading *"you don't have permission to view it"* error)
  - opens the result
- **`quick-action/Make PDF.workflow`** — a hand-rolled Automator Quick Action bundle that:
  - appears in Finder's right-click menu **only for Markdown files** (matched on the `net.daringfireball.markdown` UTI)
  - passes the selected files to `/usr/local/bin/m`

No Automator app needed to build or edit it — the workflow is just two plists, checked in as plain text.

## Install

Requires [Node.js](https://nodejs.org) and the `md-to-pdf` npm package:

```bash
npm install -g md-to-pdf
git clone https://github.com/krunkosaurus/md2pdf-quick-action.git
cd md2pdf-quick-action
./install.sh
```

The installer copies `m` to `/usr/local/bin` and the Quick Action to `~/Library/Services`, then refreshes the Services registry so it appears immediately. If "Make PDF" doesn't show up in the right-click menu right away, run `killall Finder` or log out and back in.

## Uninstall

```bash
./uninstall.sh
```

## Why the PATH juggling in `bin/m`?

Finder Quick Actions run shell scripts with a minimal environment (`/usr/bin:/bin:/usr/sbin:/sbin`). The script prepends `~/.local/bin`, `/usr/local/bin`, and `/opt/homebrew/bin` so it can find `node` and `md-to-pdf` no matter how they were installed.

## License

MIT
