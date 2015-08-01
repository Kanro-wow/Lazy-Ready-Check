if LazyReadyCheck == nil then LazyReadyCheck = { ["login"] = false, } end
local strings = {
	["on"] = [[Turned |cff33CC33on|r! Will accept ready checks.]],
	["off"] = [[Turned |cffFF0000off|r! Will ignore ready checks.]],
	["options"] = [[Type /LRC for options]],
	["lrc"] = [[|cffFFA500LazyReadyCheck:|r]],
	["onLogin"] = [[|cff33CC33Turned on after login!|r! When logging in, addon will accept ready checks!]],
	["offLogin"] = [[|cffFF0000Turned off after login|r! When logging in, addon will ignore ready checks!]],
	["onOff"] = [[/LRC on/off - autoaccept or ignore ready checks]],
	["onOffLogin"] = [[/LRC login on/off- turn on Lazy Ready Check when logging in]],
}

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	if msg == "on" or msg == "enable" then
		print(strings["lrc"],strings["on"])
		ReadyCheckFrameYesButton.elapsed = math.random(10,50)/10
		enabled = true
	elseif msg == "off" or msg == "disable" then
		print(strings["lrc"],strings["off"])
		ReadyCheckFrameYesButton:SetText(READY)
		enabled = false
	elseif msg == "login on" then
		LazyReadyCheck.login = true
		print(strings["lrc"],strings["onLogin"])
	elseif msg == "login off" then
		LazyReadyCheck.login = false
		print(strings["lrc"],strings["offLogin"])
	else
		print(strings["lrc"],strings["onOff"])
		print(strings["lrc"],strings["onOffLogin"])
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self,event,...)
	local enabled = LazyReadyCheck.login
	if enabled then
		print(strings["lrc"],strings["options"])
	else
		print(strings["lrc"],strings["options"])
	end
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