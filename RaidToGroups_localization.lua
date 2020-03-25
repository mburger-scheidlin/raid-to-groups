local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
MyLocalizationTable = setmetatable({}, {__index=defaultFunc});

local L = MyLocalizationTable;
if GetLocale() == "deDE" then
	L["welcome_message"]   = "Raid to Groups geladen. Benutze den Befehl /rtg.";
	L["not_in_raid"]       = "Du bist nicht in einer Raidgruppe";
	L["wrong_command"]     = "Ungültiger Befehl"
	L["usage"]             = "Erstelle einen Raid und organisie die Spieler in den gewünschten Gruppen.";
	L["usage_print"]       = "benutze /rtg print um das Gruppenlayout in den Raid-Chat zu posten";
	L["usage_whisper"]     = "benutze /rtg whisper um spielern Anweisungen zu flüstern.";
	L["usage_disband"]     = "benutze /rtg disband um den Raid aufzulösen";
	L["SPACER"]            = "    ";
	L["GROUP"]             = "GRUPPE";
	L["invites"]           = "(läd ein)";
	L["inv"]               = "inv";
	L["invite_from"]       = "Du erhälst einen invite von";
	L["radisband_message"] = "Raid aufgelöst von";
else
	L["welcome_message"]   = "Raid to Groups loaded. Use /rtg to start.";
	L["not_in_raid"]       = "Your are not in a raid";
	L["wrong_command"]     = "Command not recognized"
	L["usage"]             = "Create a Raid and organize the groups as you like first.";
	L["usage_print"]       = "use /rtg print to print the group layout to raid-chat.";
	L["usage_whisper"]     = "use /rtg whisper to whisper instruction to individual people.";
	L["usage_disband"]     = "use /rtg disband to disband the raid";
	L["SPACER"]            = "    ";
	L["GROUP"]             = "GROUP";
	L["invites"]           = "(invites)";
	L["inv"]               = "inv";
	L["invite_from"]       = "You will get an invite from";
	L["radisband_message"] = "Raid disbanded by";
end