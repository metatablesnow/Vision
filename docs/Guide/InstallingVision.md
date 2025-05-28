# Installing Vision

## Install via Wally <small>recommended</small> { #installing-via-wally data-toc-label="Installing via Wally" }

Vision is published as a [Wally](http://www.wally.run) package and can be installed as a dependency. 

1. Add Vision to your `wally.toml` dependency list

    ```toml title="wally.toml"
    [dependencies]
    Vision = "metatablesnow/vision@0.1.0"
    ```

2. Install the dependency  inside the terminal
   ```sh title="terminal"
   wally install
   ```

This will install Vision to your `Packages` folder.

??? info "What is Wally?" 
    Wally is a package manager for Roblox, inspired by Cargo and npm. It brings the familiar, community-oriented world of sharing code from other communities into the Roblox ecosystem.

## Installing via Roblox
If you are creating a Roblox experience, you can import a roblox model file (`.rbxm`) containing Vision.

1. Download the `.rbxm` file from [Visions "Releases" page](http://www.github.com/metatablesnow/Vision/releases)
2. Inside of Roblox Studio, right-click on `ReplicatedStorage` and select "Insert from File..."
3. Select the `Vision.rbxm` file you downloaded, Vision should now be inside of Replicated Storage

??? warning "Don't Miss Important Updates!"
    If you aren't using a package manager like Wally, you may miss important updates! We're working hard to make a Roblox package so you can receive auto-update. In the meantime, watch the GitHub repository for releases to be notified when a new release is published.

## Setup

Follow the steps below to setup Vision on the server and client:
=== ":fontawesome-solid-server:&nbsp;&nbsp; Server Setup"
    Inside of a server script, which should be inside of `ServerScriptService`, you can require Vision, and optionally register the default commands (teleport, kill, etc.), and some useful apps (calculator,  debug, etc.)
    ```lua title="InitiateVision.server.luau"
    local Vision = require(path.to.Vision)

    Vision:RegisterBuiltInCommands() -- This runs Vision:RegisterBuiltInApps()
    ```
=== ":fontawesome-solid-computer:&nbsp;&nbsp;Client Setup"
    Inside of a client script, you can require Vision and optionally set hotkeys to open Vision.
    ```lua title="InitiateVision.client.luau"

    local Vision = require(path.to.Vision)

    Vision:SetHotkeys({
      {Enum.KeyCode.Ctrl, Enum.KeyCode.R} -- These can be key-combos, or single keys
    })
    ```

!!! success "Thats All!"
    You can now press the hotkeys you assigned, and Vision should appear. Keep reading to learn how to create your own commands, types, and more!
