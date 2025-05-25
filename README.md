<img width="400" style="height:auto;" src="./github-assets/vision-dark-theme.svg#gh-dark-mode-only" alt="Vision Logo">

### Redefine how you interact with your code

> Vision is currently in active development. The API is subject to change, and you may encounter bugs or incomplete features. Use with caution in production environments.

**Vision** is a modern, lightweight command bar built for all  Roblox experiences—from massive, multiplayer games with dozens of developers, to small personal projects shared among friends. It’s designed to feel native, intuitive, and powerful right out of the box.

With Vision, you can easily build commands and mini-apps that:
- Trigger server or client functions (or both!)
- Open custom menus and interfaces
- Reward players with in-game items or currency
- Run admin or developer utilities
- ...and much more

You’ll enjoy a clean, readable API, full autocomplete support, flexible argument parsing, and built-in aliasing—giving both developers and power users the tools to move quickly and efficiently.

Vision was built to be:
- 🔌 **Extensible** – Add your own behaviors and integrations without editing Vision itself
- 🧠 **Adaptable** – Use it in a live game, testing experience, or studio
- 🧩 **Modular** – Keep your code organized, scalable, and easy to maintain

### 📦 Installation

#### With Wally (Recommended)
[Wally](https://github.com/UpliftGames/wally) is a modern package manager for Roblox Projects.

1. Add Vision to your `wolly.toml` dependencies (e.g. `Vision = "blank/visual@1.0.0"`)
2. Run `wally install` inside of the terminal.
3. Require Vision like any other package installed with wally.

#### Roblox Studio
1. Download the `.rbxm` file from the our [Latest Releases] page.
2. Drag the file into the viewport.

### 🛠️ Getting Started

#### Server Setup
```lua
local Visual = require(path.to.Visual.Server)

Visual:AddBuiltInCommands()
```

#### Client Setup
```lua
local Visual = require(path.to.Visual.Client)

Visual:Build({
  {Enum.KeyCode.Crtl, Enum.KeyCode.F}
})
```
