local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Dependencies = (script.Parent :: Instance).Parent

local Shared = {}

Shared.Registry = require(script.Registry)
Shared.Commands = script.Commands
Shared.RemoteEvent = script:WaitForChild("RemoteEvent") :: RemoteEvent
Shared.RemoteFunction = script:WaitForChild("RemoteFunction") :: RemoteFunction

Shared.Fusion = require(Packages.Fusion)

return Shared
