# Golem First Jam — Architecture Summary

This project, built in Godot with GDScript, is organized into five subdomains: `entities`, `managers`, `handlers`, `states`, and `systems`. Each has a specific role, and their interactions follow strict rules to maintain a clean, hexagonal-inspired architecture tailored for Godot. This layering is from Alex Temina :TM: — see that repo if you want a worked example with real content.

## Directory Structure Overview

```plaintext
/golem_first_jam
├── /entities/                     # Physical game objects (meshes, UI, etc.)
├── /managers/                     # Orchestrators
├── /handlers/                     # Non-visual helpers
├── /states/                       # Global state (autoloads)
│   ├── /signal_bus/               # signal-only autoload; the project's message bus
├── /systems/                      # Static utilities
/docs/                             # Design docs
project.godot
```

The project is freshly scaffolded — most of these folders are empty except for `.gitkeep`. Fill them in as the jam progresses, following the rules below.

## Components

### 1. Entities
- **Location**: `/golem_first_jam/entities/`
- **Definition**: Nodes with physical or visual representation in the game (3D meshes, colliders, lights, UI elements).
- **Purpose**: Represent tangible game objects that occupy space or are visible.
- **Interaction Rules**:
  - **Can**: Emit signals to `SignalBus` (in `/states/signal_bus/`) for events.
  - **Cannot**: Call `managers`, `handlers`, `states`, or react to `SignalBus` signals. They are passive, only emitting signals.
- **Relationships**: Controlled by `managers`, which instantiate and manipulate them. Entities send signals to notify `managers` of events.

### 2. Handlers
- **Location**: `/golem_first_jam/handlers/`
- **Definition**: Non-visual ("white") nodes acting as modular helpers for `managers`, providing specific functionality (e.g. movement, hover detection, save/load).
- **Purpose**: Encapsulate reusable, non-visual logic to support `managers`.
- **Interaction Rules**:
  - **Can**: Be called by `managers`, emit signals to `SignalBus`, read `states` (mediated by `managers` where possible).
  - **Cannot**: Have physical representation or call `entities` directly.
- **Relationships**: Tools for `managers`, extending functionality. They may emit signals to notify `managers`.

### 3. Managers
- **Location**: `/golem_first_jam/managers/`
- **Definition**: Nodes that orchestrate child nodes (`entities` and `handlers`).
- **Purpose**: Act as the "brains," managing the lifecycle and interactions of `entities` and `handlers`, and updating `states`.
- **Interaction Rules**:
  - **Can**: Call `entities` and `handlers`, read/write `states`, listen to `SignalBus`.
  - **Cannot**: Be called directly by `entities` (only signaled).
- **Relationships**: Central hubs, orchestrating `entities` and `handlers`, mediating with `states`, and handling `SignalBus` events.

### 4. States
- **Location**: `/golem_first_jam/states/`
- **Definition**: Autoload singletons storing global game state, acting as a centralized "database."
- **Purpose**: Persist and manage global state, often tied to a sibling `manager`.
- **Usage**: Registered in `project.godot` (file names `snake_case`, `.tscn` preferred over bare `.gd` once a state grows beyond a signal bus):
  ```plaintext
  [autoload]
  SignalBus="*res://golem_first_jam/states/signal_bus/signal_bus.gd"
  ```
- **Interaction Rules**:
  - **Can**: Be read/written by `managers`, read by `handlers` (sparingly), emit signals.
  - **Cannot**: Be accessed by `entities`.
- **Relationships**: Global state repositories, primarily managed by sibling `managers`. `SignalBus` routes signals.

### 5. Systems
- **Location**: `/golem_first_jam/systems/`
- **Definition**: Static utility scripts for helper functions or data processing (e.g. math, geometry).
- **Purpose**: Provide reusable, stateless logic.
- **Interaction Rules**:
  - **Can**: Be called by `managers`, `handlers`, `entities`.
  - **Cannot**: Interact with `states` or `SignalBus`.
- **Relationships**: Library of tools, supporting other components.

## Key Interaction Rules
1. **Entities**: Can emit signals to `SignalBus`. Cannot call `managers`, `handlers`, `states`, or react to `SignalBus`.
2. **Handlers**: Can be called by `managers`, emit signals to `SignalBus`, read `states` (mediated). Cannot have physical representation or call `entities`.
3. **Managers**: Can call `entities`, `handlers`, read/write `states`, listen to `SignalBus`. Cannot be called by `entities` (only signaled).
4. **States**: Can be read/written by `managers`, read by `handlers`, emit signals. Cannot be accessed by `entities`. `SignalBus` used by `entities`/`handlers` to emit and `managers` to listen.
5. **Systems**: Can be called by anyone. Cannot interact with `states` or `SignalBus`.
