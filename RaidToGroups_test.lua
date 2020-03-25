-- TESTS

local function IsInRaid_test()
    return true;
end	

local function GetRaidRosterInfo_test(i)
    --                          NAME         RANK  GRP
	if      i == 1  then return "Urquart"     , 2, 1;
	elseif  i == 2  then return "Daranei"     , 0, 3;
	elseif  i == 3  then return "Berwin"      , 0, 8;
	elseif  i == 4  then return "Kagrimor"    , 1, 8;
	elseif  i == 5  then return "Unas"        , 0, 7;
	elseif  i == 6  then return "Yassy"       , 1, 7;
	elseif  i == 7  then return "Paneer"      , 1, 7;
	elseif  i == 8  then return "Alleister"   , 1, 2;
	elseif  i == 9  then return "Kagrimor"    , 0, 2;
	elseif  i == 10 then return "Sharrak"     , 0, 2;
	elseif  i == 11 then return "Alram"       , 0, 5;
	elseif  i == 12 then return "Harzerrolle" , 0, 5;
	elseif  i == 13 then return "Bierkanone"  , 0, 6;
    end
end

local function parseRaid_test()
    local raidgroup = {}
	for i = 1, 13 do
		-- get playerName and Group
		local n,r,g = GetRaidRosterInfo_test(i);
		if n and r and g then
			-- check if group-array exists and create one if needed
			if raidgroup[g] == nil then
				raidgroup[g] = {};
			end
			if r > 0 then 
			    table.insert(raidgroup[g],1,n);
			else 
			    table.insert(raidgroup[g],n);
			end
		end
	end
	return raidgroup;
end

local function radisband_test()
	print(L["radisband_message"] .. " " .. UnitName("player"));
end


-- sends the group layout to the chat
local function printGroup_test(grnum, grp)
	if #grp >= 2 then
		print(L["GROUP"] .. " " .. grnum);
		print (L["SPACER"] .. grp[1] .. " " .. L["invites"]);
		for i = 2, #grp do
			print(L["SPACER"] .. grp[i]);
		end
	elseif #grp == 1 then
		print(L["GROUP"] .. " " .. grnum);
		print (L["SPACER"] .. grp[1]);
	end
end

-- sends invite links as whispers to the first member of the group
local function sendInviteLinks_test(grp)
    if #grp >= 2 then
		for i = 2, #grp do
			print(L["inv"] .. " " .. grp[i] .. " WHISPER " .. grp[1]);
			print(L["invite_from"] .. " " .. grp[1] .. " WHISPER " .. grp[i]);
		end
	end
end

-- main function
-- parses the raid, disbands it and sends invite links
local function raidToGroups_test(msg)
	if (IsInRaid_test()) then
		local raidgroup = parseRaid_test();
		if msg == 'print' then
			if raidgroup ~= nil then
				for i = 1 , #raidgroup, 1 do
					if raidgroup[i] ~= nil then
						printGroup_test(i, raidgroup[i]);
					end
				end
			end	
		elseif msg == 'disband' then
			radisband_test();
		elseif msg == 'whisper' then	
			if raidgroup ~= nil then
				-- send whispers
				for i = 1, #raidgroup, 1 do
					if raidgroup[i] ~= nil then
						sendInviteLinks_test(raidgroup[i]);
					end
				end
			end
		else
			print (L["wrong_command"]);
			print (L["usage_print"]);
			print (L["usage_whisper"]);
			print (L["usage_disband"]);		
		end
	else
		print (L["not_in_raid"]);
		print (L["usage"]);
		print (L["wrong_command"]);
		print (L["usage_print"]);
		print (L["usage_whisper"]);
		print (L["usage_disband"]);
	end
end