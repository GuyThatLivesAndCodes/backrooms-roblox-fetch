-- systems.lua
-- Hosted at: https://blox.guythatlives.net/scripts/systems.lua
-- Master loader — fetches and runs sub-systems from the same domain

local Systems = {}
local BASE_URL = "https://blox.guythatlives.net/scripts/"

local HttpService = game:GetService("HttpService")

local function fetchModule(path)
	local ok, result = pcall(function()
		return HttpService:GetAsync(BASE_URL .. path, true)
	end)
	if not ok then
		warn("[Systems] Failed to fetch " .. path .. ": " .. tostring(result))
		return nil
	end
	local fn, err = loadstring(result)
	if not fn then
		warn("[Systems] Parse error in " .. path .. ": " .. tostring(err))
		return nil
	end
	return fn()
end

-- Load sub-systems
Systems.Animations = fetchModule("animations.lua")
-- Systems.GUI        = fetchModule("gui.lua")
-- Systems.Inventory  = fetchModule("inventory.lua")
-- Systems.Audio      = fetchModule("audio.lua")

return Systems
