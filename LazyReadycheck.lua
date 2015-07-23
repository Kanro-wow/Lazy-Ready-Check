local f = CreateFrame("Frame")
local green = string.format("|cff%02x%02x%02x",124,252,0).."LazyReadyCheck: |r"

f:SetScript("OnEvent", function(self,event,...)
	local time = math.random(1,4)
	print(green.."Accepting in",time,"seconds")
	C_Timer.After(time, function() ReadyCheckFrameYesButton:Click() end)
end)

SLASH_LAZYREADYCHECK1 = "/lrc"
SLASH_LAZYREADYCHECK2 = "/lazyreadycheck"
SlashCmdList["LAZYREADYCHECK"] = function(msg, editbox)
	if msg == "enable" then
		f:RegisterEvent("READY_CHECK")
		print(green.."Registered event, will accept readychecks")
		ReadyCheckFrameYesButton:Click()
	elseif msg == "disable" then
 		f:UnregisterEvent("READY_CHECK")
		print(green.."Unregistered event, will no longer accept readychecks")
	else
		print(green.."/lrc enable - autoaccept readychecks")
		print(green.."/lrc disable - ignore readychecks")
	end
end
