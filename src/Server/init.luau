local function newInstance(className, parent)
	local instance = Instance.new(className)
	instance.Parent = parent

	return instance
end

local Server = {
	RemoteEvent = newInstance("RemoteEvent") :: RemoteEvent,
	RemoteFunctuion = newInstance("RemoteFunction") :: RemoteFunction,
}

return Server
