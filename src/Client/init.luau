local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(script.Parent.Shared)

local Client = {}
Client.__index = Shared.Registry

Client.UI = require(script.UI)
Client.Shared = Shared

function Client:BuildUI() end

Shared.Registry:RegisterCommandsIn(Shared.Commands)
Shared.Commands.ChildAdded:Connect(function(command)
	if command:IsA("ModuleScript") then
		Shared.Registry:RegisterCommand(command)
	end
end)

return Client
