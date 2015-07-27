local f = CreateFrame("Frame")
local countdownF = CreateFrame("Frame","LCR_Countdown")
countdownF.counter = CreateTexture(nil, "ARTWORK")
f:RegisterEvent("PLAYER_LOGIN")
local enabled = false

local orange = string.format("|cff%02x%02x%02x",255,165,0).."LazyReadyCheck: |r"
if LazyReadyCheck == nil then LazyReadyCheck = { ["onLoad"] = false, } end

local function registerEvents(enable)
	if enable then
		f:RegisterEvent("READY_CHECK")
		print(orange.."Turned |cff33CC33on|r! Will accept readychecks. Type /lrc for options")
		enabled = true
	else
		f:UnregisterEvent("READY_CHECK")
		print(orange.."Turned |cffFF0000off|r! Will ignore readychecks. Type /lrc for options")
		enabled = false
	end
end

f:SetScript("OnEvent", function(self,event,...)
	if event == "READY_CHECK" then
		local time = math.random(1.0,5.0)
		print(orange.."Accepting in",time,"seconds")
		C_Timer.After(time, function()
			ReadyCheckFrameYesButton:Click()
		end)
	elseif event == "PLAYER_LOGIN" then
		countdownF:SetSize(100,100)
		countdownF.counter:SetNormalFontObject(_G["GameFontNormal"])


		registerEvents(LazyReadyCheck.onLoad)
	end
end)

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	-- if string.len(msg) == 0 then
	-- 	registerEvents(not enabled)
	-- else
	if msg == "enable" then
		registerEvents(true)
	elseif msg == "disable" then
		registerEvents(false)
	elseif msg == "onload true" then
		LazyReadyCheck.onLoad = true
		print(orange.."|cff33CC33Turned on during login!|r! When logging in, addon will accept ready checks!")
	elseif msg == "onload false" then
		LazyReadyCheck.onLoad = false
		print(orange.."|cffFF0000Turned off during login|r! When logging in, addon will ignore ready checks!")
	else
		print(orange.."/lrc - will toggle the addon on or off")
		print(orange.."/lrc enable - autoaccept readychecks")
		print(orange.."/lrc disable - ignore readychecks")
		print(orange.."/lrc onload true/false- turn on Lazy Ready Check on logging in")
	end
end
