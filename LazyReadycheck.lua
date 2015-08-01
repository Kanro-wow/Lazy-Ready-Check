if LazyReadyCheck == nil then LazyReadyCheck = { ["login"] = false, } end
local strings = {
	["on"] = [[Turned |cff33CC33on|r! Will accept ready checks.]],
	["off"] = [[Turned |cffFF0000off|r! Will ignore ready checks.]],
	["options"] = [[Type /LRC for options]],
	["lrc"] = [[|cffFFA500LazyReadyCheck:|r]],
	["logon"] = [[|cff33CC33Turned on after login!|r! When logging in, addon will accept ready checks!]],
	["logoff"] = [[|cffFF0000Turned off after login|r! When logging in, addon will ignore ready checks!]],
	["onOff"] = [[/LRC on/off - autoaccept or ignore ready checks]],
	["onOffLogin"] = [[/LRC login on/off- turn on Lazy Ready Check when logging in]],
}

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	local arg= {}
	for word in msg:gmatch("%w+") do table.insert(arg, word) end
	if arg[1] == "on" or arg[1] == "off" then
		print(strings["lrc"],strings[arg[1]])
		ReadyCheckFrameYesButton:SetText(READY)
		ReadyCheckFrameYesButton.elapsed = math.random(10,50)/10
		enabled = (arg[1] == "on" and true or false)
	elseif arg[1] == "login" and (arg[2] == "off" or arg[2] == "on") then
		LazyReadyCheck.login = (arg[2] == "on" and true or false)
		print(strings["lrc"],(arg[2] == "on" and strings["logon"] or strings["logoff"]))
	else
		print(strings["lrc"],strings["onOff"])
		print(strings["lrc"],strings["onOffLogin"])
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self,event,...)
	local enabled = LazyReadyCheck.login
	print(strings["lrc"],strings["options"])
end)

ReadyCheckFrameYesButton:HookScript("OnUpdate",function(self,elapsed)
	if enabled then
		self.elapsed = self.elapsed - elapsed
		self:SetFormattedText('%s |cffffffff(%.1f)|r', READY, self.elapsed)
		if(self.elapsed <= 0) then
			self:SetText(READY)
			self:Click()
		end
	end
end)

ReadyCheckFrameYesButton:HookScript("OnShow", function(self)
	self.elapsed = math.random(10,50)/10
end)

