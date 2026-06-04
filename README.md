# Journal — GitLab Pages site

A minimal static blog built from plain `.md` files. No build tools, no frameworks.

## Structure

```
.
├── index.html              ← the entire site
├── .gitlab-ci.yml          ← auto-deploys on push to default branch
├── generate-manifest.sh    ← local dev helper
└── articles/
    ├── journal_001.md
    ├── journal_002.md
    └── ...
```

## Adding articles

Drop a new `.md` file in `articles/`. The filename must contain a numeric suffix that determines display order:

```
journal_042.md
note_007.md
2024-entry_099.md   ← the last run of digits before .md is used
```

The site reads this number, sorts ascending, and shows the highest-numbered file as the landing entry.

## Article format

Plain markdown. No front-matter required. The first `# Heading` becomes the article title shown in the archive drawer.

```markdown
# My Title

First paragraph here.

Second paragraph here.
```

## Local preview

You need a local HTTP server (browsers block `fetch()` on `file://`):

```bash
# generate the manifest first
./generate-manifest.sh

# serve with python
python3 -m http.server 8080

# or npx
npx serve .
```

Then open http://localhost:8080.

## Deployment

Push to your default branch. The `.gitlab-ci.yml` pipeline:

1. Copies `index.html` and all `articles/*.md` into `public/`
2. Generates `public/articles/manifest.json` (the file list the JS reads)
3. Hands `public/` to GitLab Pages

Enable Pages under **Settings → Pages** in your GitLab project if you haven't already.

## Navigation

- **Latest entry** loads on arrival
- **Archive** button (top right) opens a slide-in drawer listing all entries newest-first
- **← prev / next →** buttons step through entries in order
- **Arrow keys** ← → also navigate
- **?n=42** query param links directly to a specific entry number
