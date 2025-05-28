# Commands

No commands are registered by default. To learn how to enable built in commands, see [Default Commands](#default-commands).

To create a command, create a `ModuleScript` into a folder which returns a command definition:

```lua title="invisible.lua"
return {
    Name = "invisible",
    Aliases = { "invis" },

    UndoName = "visible"
    UndoAliases = { "vis" }

    Description = "Makes a player or a group of players invisible",
    UndoDescription = "Makes a player or a group of players visible",

    App = "Basic Commands",
    Arguments = {
        {
            Name = "players",
            Type = "players",
            Description = "The players to make invisible",
            -- Custom function that the "players" type has
            ForEachClient = function(player)
                -- e.g. render player half-invisible on the client
            end
        }
    }
}
```
Server logic belongs in its own `ModuleScript` with the same name but with a "Server" suffix, which returning a single function.

```lua title="invisibleServer.lua"
return function(context, players)
    -- Arguments already validated and type-checked!
    -- Optional args = nil or an empty table if listable.
    for index, player in players do
        -- Make the player invisible on the server
    end
end
```


??? tip "Server Functions Are Never Exposed to the Client"
    You can safely include secrets (e.g., webhook URLS) here without worrying if it will be exposed to the client.

## Wrapping Functions
Functions can be "wrapped" and turned into a command:

```lua title="wrapping.lua"

local function notifyPlayer(player, title, text)
    Vision:RunCommand("notify", player, title, text)
end

Vision:Wrap(notifyPlayer, {"players", "string", "string"})
```

Wrapped functions will automatically inherit the name of the function.

??? info "What about Anonymous Functions?"
    If the wrapped function is [anonymous](https://create.roblox.com/docs/luau/functions#anonymous-functions),  the *first* item inside of the arguments table should be the command name.

    ```lua
    Vision:Wrap(function(soundId)
        -- Play the sound...
    end, {"playSound", "assetId"})
    ```

---

To add names and descriptions to the types, make them a table:
=== ":fontawesome-solid-list-ol:&nbsp;&nbsp; Array Formatting"  
    You can use an array to format your arguments, the only required parameter for each argument is `Type` (#3):

    ```lua
    local arguments = {
        {
            [1] = "Name",
            [2] = "Description",
            [3] = "Type"
        },
        {
            "Speed",
            "The speed to give the players",
            "number"
        }
    }
    ```
=== ":fontawesome-solid-list:&nbsp;&nbsp; Dictionary Formatting"
    You can also use a dictionary to format your arguments, the only required parameter for each argument is `Type`:

    ```lua
    local arguments = {
        {
            Name = "Name",
            Description = "Description",
            Type = "Type"
        },
        {
            Name = "Speed",
            Description = "The speed to give the players",
            Type = "number"
        }
    }
    ```
=== ":fontawesome-solid-bolt:&nbsp;&nbsp; Quick Formatting"
    If you don't need to set the name or description of a command, you can do so like this:
    ```lua
    local arguments = {"string", "numbers", "player"}
    ```

## Command Data

To gather client-side data (mouse position, device, etc.) define `DataType`, and `Data`, for example:

```lua title="command.lua"
DataType = "CFrame" -- or a table (e.g. {MousePos = "CFrame", MouseHitPos = "CFrame"})
Data = function(localPlayer)
    return localPlayer:GetMouse().Hit.Position
end
```

This data is then available for the server in `context.Data`.

## Execution Order
1. `BeforeRun` client hook.
2. `Data` function on the client.
3. `ClientRun` function on the client.
4. `BeforeRun` server hook. *
5. `ServerRun` (if present) *
6. `AfterRun` hook on server *
7. `AfterRun` hook on client.

\* Only runs if `ClientRun` isn't present or returns `nil`.

## Default Commands
If you run `Vision:RegisterBuiltInCommands()` the following commands and apps will be registered:

**App:** `Vision`

- `toast state (player)`
- `hint message (player)`


If you want to blacklist certain built-in commands, `Vision:RegisterBuiltInCommands()` has a `filter` parameter:

```
local blacklistedCommands = {"toast", "hint"}

Vision:RegisterBuiltInCommands(function(command)
    -- return true to register, false to skip
    return blacklistedCommands[command.Name] == nil
end)
```

## Argument Aliases
Instead of having to type out the entire argument, you can use the following aliases as a shorthand:

| Alias | Meaning                                                       | Requirements                                                      |
| ----- | ------------------------------------------------------------- | :---------------------------------------------------------------- |
| .     | Default value                                                 | `Default` function present                                        |
| *     | All possible values                                           | `Listable` and `All`/`Autocomplete` functions present             |
| **    | All possible values except the default value                  | `Listable`, `All`/`Autocomplete`, and `Default` functions present |
| ?     | A random value picked from all possible values                | `All`/`Autocomplete` function present                             |
| ?n    | A number (n) of random values picked from all possible values | `Listable` and `All`/`Autocomplete`h functions present            |
| !     | The last value(s) used                                        | The type has been used before                                     |

!!! tip "Combining Aliases"
    You can combine aliases with a + or a - to add/remove items. (e.g. `?-.` picks a random value excluding the default value.)