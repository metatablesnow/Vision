local UI = script.Parent
local Client = UI.Parent
local Shared = require(Client.Parent.Shared)
local Fusion = Shared.Fusion

local scoped = Fusion.scoped()

return function()
	local scope = scoped(Fusion)

	scope:New("CanvasGroup")({})
end
