if LazyReadyCheck == nil then LazyReadyCheck = { ["enabled"] = false, } end
local lrc = [[|cffFFA500LazyReadyCheck:|r]]

local L = select(2, ...)

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	local _msg = string.lower(msg)
	if _msg == L["on"] or _msg == L["enable"] then
		print(lrc,L["Turned ON! Will accept ready checks."])
		ReadyCheckFrameYesButton.elapsed = math.random(10,50)/10
		LazyReadyCheck.enabled = true
	elseif _msg == L["off"] or _msg == L["disable"] then
		print(lrc,L["Turned OFF! Will ignore ready checks."])
		ReadyCheckFrameYesButton:SetText(READY)
		LazyReadyCheck.enabled = false
	else
		print(lrc,L["/LRC on/off - autoaccept or ignore ready checks."])
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self,event,...)
	if LazyReadyCheck.enabled then
		print(lrc,L["Type /LRC for options. Currently turned on!"])
	else
		print(lrc,L["Type /LRC for options. Currently turned off!"])
	end
end)

ReadyCheckFrameYesButton:HookScript("OnUpdate",function(self,elapsed)
	if LazyReadyCheck.enabled then
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
