# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

*Golem First Jam* is a Godot 4.7 (GDScript) project — a game jam entry for the
Golem studio. Design docs, when they exist, live under `docs/`.

## Commands

There is no test suite, linter, or build step in this repo — it's a Godot
project opened/run through the editor. The relevant CLI entry points:

- **Open/run in editor**: `godot --path .` (or open `project.godot` from the
  Godot editor). Set `run/main_scene` in `project.godot` once there's a scene
  to run.
- **Headless reimport**: `godot --headless --path . --import`.

## Architecture

The codebase (`golem_first_jam/`) follows the same strict, hexagonal-inspired
layering from Alex Temina :tm: — see `README.md` for the full
breakdown, per-layer purpose, and interaction rules. In short:

- **`entities/`** — physical/visual nodes (meshes, colliders, UI). Passive:
  they may *emit* signals to `SignalBus` but cannot call managers/handlers/
  states or react to bus signals.
- **`handlers/`** — non-visual helper nodes used by managers. Can be called by
  managers, emit to `SignalBus`, read `states` sparingly. Cannot touch
  entities directly or have visual form.
- **`managers/`** — orchestrators; the only layer that drives entities and
  handlers, reads/writes `states`, and listens to `SignalBus`. Never called
  directly by entities (only signaled).
- **`states/`** — autoload singletons (registered in `project.godot`, file
  names `snake_case`) that hold global state and emit change signals. Written
  by managers, read by handlers/managers, never by entities. `SignalBus`
  (also here) is the project's global signal router.
- **`systems/`** — stateless static utility libraries, callable from
  anywhere, but never touch states or the bus.

The project is a fresh scaffold: most folders only hold a `.gitkeep`. As
content gets added, keep it in the right layer per the rules above rather
than letting logic accrete in one place.
