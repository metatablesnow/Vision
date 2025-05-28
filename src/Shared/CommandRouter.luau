local Registry = require(script.Parent.Registry)

local CommandRouter = {}

function CommandRouter:EvaluateAndRun(text)
	local arguments = string.split(text, " ")
	local commandsName = table.remove(arguments, 1)

	if not Registry.Commands[commandsName] then
		return false, "No command with the name " .. commandsName .. " was found"
	end
end

function CommandRouter:Run(commandContext) end

return CommandRouter
