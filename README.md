# Twine SugarCube Mystery Escape Starter

This is a starter project for a mystery + escape-room style Twine game using SugarCube.

## Story Premise
You wake on the "Quiet Floor" of Aster House, a mansion that reconfigures itself at midnight.

Someone left you a note:
"Find Ada before the Bell, or join the house."

Each room has clues, locks, and fragments of a larger mystery. You must solve local puzzles to unlock deeper floors and piece together what happened to Ada, the missing architect of the estate.

## Project Structure
- `minigames/`: one folder per mini-game
- `minigames/twine-mystery-starter/quiet-floor.twee`: first mini-game source
- `dist/`: build output used for deployment (`index.html` only)

## Local build

1. Install Tweego:
	- npm run setup
2. Build:
	- npm run build
3. Open the compiled game:
	- dist/index.html

All `.twee` files under `minigames/` are compiled together into the same game output.

Notes:
- The installer downloads the official Tweego release binary into `.tools/tweego`.
- The build script automatically downloads SugarCube `2.37.3` into `.storyformats/` when needed.

## Local preview server

From project root:

npm run preview

Then open http://localhost:8080.

## Deployment (GitHub Pages)

This project matches the same deployment style as your proxy project.

A workflow at `.github/workflows/deploy-pages.yml` will:

1. Build all mini-game folders under `minigames/`
2. Upload `dist` as the Pages artifact
3. Deploy to GitHub Pages on every push to `main`

### CI check for PRs

`.github/workflows/pr-build-check.yml` compiles the story on pull requests to `main` so broken Twine builds are caught before merge.

### One-time repo setup

1. In GitHub repo settings, go to **Pages**.
2. Set **Source** to **GitHub Actions**.
3. Push to `main`.

After that, deployment is automatic.

## How To Use In Twine 2
1. Open Twine 2.
2. Create a new story and set Story Format to SugarCube 2.
3. Install Tweego if you want direct `.twee` import/export workflows.
4. Copy passages from your game's `.twee` file into your story, or compile with Tweego.

## Add Another Mini-Game
1. Create a new folder under `minigames/` (example: `minigames/door-2`).
2. Add one `.twee` file to that folder.
3. Run `npm run build`.

Its passages will be merged into the same compiled game at `dist/index.html`.

## What Is Already Implemented
- Opening mystery hook and tone.
- Room navigation for the first floor loop.
- A multi-clue lock puzzle (study desk code).
- Inventory and clue tracking.
- A first progression gate (service elevator unlock).
- A chapter-end reveal to launch your next act.

## Suggested Next Steps
1. Add one additional floor section to extend the current linear playthrough.
2. Add one suspect per floor with conflicting alibis.
3. Add a "Trust" or "Suspicion" variable that changes endings.
4. Add at least one puzzle with multiple valid solutions.
5. Write a red-herring path that still rewards exploration.
