READY_CHECK_WAITING_TEXTURE = "Interface\\RaidFrame\\ReadyCheck-Waiting";
READY_CHECK_READY_TEXTURE = "Interface\\RaidFrame\\ReadyCheck-Ready";
READY_CHECK_NOT_READY_TEXTURE = "Interface\\RaidFrame\\ReadyCheck-NotReady";
READY_CHECK_AFK_TEXTURE = "Interface\\RaidFrame\\ReadyCheck-NotReady";

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
local enabled = nil

local stringLRC = [[|cffFFA500LazyReadyCheck:|r ]]
if LazyReadyCheck == nil then LazyReadyCheck = { ["login"] = false, } end

local function enableAddon(enable)
	enabled = enable
	if enable then
		print(stringLRC..[[Turned |cff33CC33on|r! Will accept ready checks.]])
		ReadyCheckFrameYesButton.elapsed = math.random(100,500)/10
	else
		print(stringLRC..[[Turned |cffFF0000off|r! Will ignore ready checks.]])
		ReadyCheckFrameYesButton:SetText(READY)
	end
end

-- local toggle = CreateFrame("BUTTON","LazyReadyCheckToggle",ReadyCheckListenerFrame)
-- toggle:SetPoint("BOTTOMRIGHT", "ReadyCheckListenerFrame", "TOPRIGHT", -5, -13)
-- toggle:SetHeight(30)
-- toggle:SetWidth(30)
-- toggle:SetScript ("OnClick", function(self) enableAddon(not enabled) end)

-- local texture = toggle:CreateTexture(nil,"ARTWORK")
-- texture:SetTexture([[Interface\Icons\inv_misc_enggizmos_30]])
-- texture:SetAllPoints()


ReadyCheckFrameYesButton:HookScript("OnUpdate",function(self,elapsed)
	if enabled then
		self.elapsed = self.elapsed - elapsed
		self:SetFormattedText('%s (|cffffffff%.1f|r)', READY, self.elapsed)
		if(self.elapsed <= 0) then
			self:SetText(READY)
			self:Click()
		end
	end
end)
ReadyCheckFrameYesButton:HookScript("OnShow", function(self)
	self.elapsed = math.random(100,500)/10
end)
enableAddon(LazyReadyCheck.login)

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	-- enable/disable deprecated
	if msg == "on" or msg == "enable" then
		enableAddon(true)
	elseif msg == "off" or msg == "disable" then
		enableAddon(false)
	elseif msg == "login on" then
		LazyReadyCheck.login = true
		print(stringLRC..[[|cff33CC33Turned on after login!|r! When logging in, addon will accept ready checks!]])
	elseif msg == "login off" then
		LazyReadyCheck.login = false
		print(stringLRC..[[|cffFF0000Turned off after login|r! When logging in, addon will ignore ready checks!]])
	else
		print(stringLRC..[[/lrc on/off - autoaccept or ignore ready checks]])
		print(stringLRC..[[/lrc login on/off- turn on Lazy Ready Check when logging in]])
	end
end


