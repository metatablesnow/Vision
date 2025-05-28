local RunService = game:GetService("RunService")

local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

local Registry = {
	Apps = {},
	Types = {},
	Commands = {},
	CommandsArray = {},
}

function Registry:RegisterApp(name, defaultIcon, defaultSubtitle)
	assert(IsClient, "You can only register apps on the client")
	assert(not Registry.Apps[name], "An app called " .. name .. " has already been registered")

	local app = {
		Name = name,
		Icon = defaultIcon,
		Subtitle = defaultSubtitle,
	}

	Registry.Apps[name] = app
end

-- Type Methods
function Registry:RegisterTypeDefinition(typeDefinition)
	Registry.Types[typeDefinition.Name] = typeDefinition

	if typeDefinition.Aliases then
		for _, alias in typeDefinition.Aliases do
			Registry.Commands[alias] = typeDefinition
		end
	end
end

function Registry:RegisterType(typeModule)
	local typeDefinition = require(typeModule)
	self:RegisterTypeDefinition(typeDefinition)

	if IsServer then
		typeModule.Parent = script.Parent.Types
	end
end

function Registry:RegisterTypesIn(instance: Instance)
	for _, typeModule in instance:GetDescendants() do
		if typeModule:IsA("ModuleScript") then
			self:RegisterType(typeModule)
		end
	end
end

-- Command Methods
function Registry:RegisterCommandDefinition(commandDefinition, serverRun)
	commandDefinition.Run = serverRun

	local oldCommandObject = Registry.Commands[commandDefinition]
	if oldCommandObject then
		if oldCommandObject.Aliases then
			for _, alias in oldCommandObject.Aliases do
				Registry.Commands[alias] = nil
			end
		end
	end

	Registry.Commands[commandDefinition.Name] = commandDefinition

	if commandDefinition.Aliases then
		for _, alias in commandDefinition.Aliases do
			Registry.Commands[alias] = commandDefinition
		end
	end
end

function Registry:RegisterCommand(commandModule: ModuleScript, serverRun: ModuleScript | () -> ())
	assert(serverRun and RunService:IsClient(), 'Paremeter "serverRun" can only be used from the server')

	local commandDefinition = require(commandModule)
	if typeof(serverRun) == "Instance" and serverRun:IsA("ModuleScript") then
		serverRun = require(serverRun)
	end

	self:RegisterCommandDefinition(commandDefinition, serverRun)

	if IsServer then
		commandModule.Parent = script.Parent.Commands
	end
end

function Registry:RegisterCommandsIn(instance: Instance)
	local serverModules = {}
	local usedServerModules = {}

	for _, command in instance:GetDescendants() do
		if command:IsA("ModuleScript") then
			if string.lower(string.sub(command.Name, -6)) ~= "server" then
				local serverModule = instance:FindFirstDescendant(command.Name .. "Server")

				if serverModule then
					usedServerModules[serverModule] = true
				end

				self:RegisterCommand(command, serverModule)
			else
				serverModules[command] = true
			end
		end
	end

	for serverModule, _ in serverModules do
		if not usedServerModules[serverModule] then
			warn(
				"Server module "
					.. serverModule.Name
					.. " was skipped because it doesn't have a matching defintion module."
			)
		end
	end
end

return Registry
