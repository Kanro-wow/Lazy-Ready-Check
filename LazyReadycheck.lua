local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

local stringLRC = [[|cffFFA500LazyReadyCheck:|r ]]
if LazyReadyCheck == nil then LazyReadyCheck = { ["login"] = false, } end

local function registerEvents(enable)
	if enable then
		f:RegisterEvent("READY_CHECK")
		print(stringLRC.."Turned |cff33CC33on|r! Will accept readychecks. Type /lrc for options")
	else
		f:UnregisterEvent("READY_CHECK")
		print(stringLRC.."Turned |cffFF0000off|r! Will ignore readychecks. Type /lrc for options")
	end
end

local function runTimer(time)
	if time then
		local acceptTime = time
		local elapsedTime = 0
		local textTime = false
		f:SetScript("OnUpdate", function(self,elapsed)
			elapsedTime = elapsedTime + elapsed
			if elapsedTime > acceptTime then
				local test = READY
				ReadyCheckFrameYesButton:SetText(test)
				ReadyCheckFrameYesButton:Click()
				return runTimer(false)
			end
			local time = string.format("%.1f", acceptTime - elapsedTime)
			if textTime ~= time then
				ReadyCheckFrameYesButton:SetText(READY.." ("..time..")")
				textTime = time
			end
		end)
	else
		f:SetScript("OnUpdate", nil)
	end
end

f:SetScript("OnEvent", function(self,event,...)
	if event == "READY_CHECK" then
		local acceptTime = math.random(100,500)/100
		runTimer(acceptTime)
		print(stringLRC.."Accepting in",math.ceil(acceptTime),"~ seconds")
	elseif event == "PLAYER_LOGIN" then
		registerEvents(LazyReadyCheck.login)
	end
end)

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	-- enable/disable deprecated
	if msg == "on" or msg == "enable" then
		registerEvents(true)
	elseif msg == "off" or msg == "disable" then
		registerEvents(false)
	elseif msg == "login on" then
		LazyReadyCheck.login = true
		print(stringLRC.."|cff33CC33Turned on during login!|r! When logging in, addon will accept ready checks!")
	elseif msg == "login off" then
		LazyReadyCheck.login = false
		print(stringLRC.."|cffFF0000Turned off during login|r! When logging in, addon will ignore ready checks!")
	else
		print(stringLRC.."/lrc on/off - autoaccept or ignore readychecks")
		print(stringLRC.."/lrc login on/off- turn on Lazy Ready Check when logging in")
	end
end
