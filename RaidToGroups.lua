-- constructs a 2-dim array according to raid groups
local function parseRaid()
    local raidgroup = {};
	for i = 1, GetNumGroupMembers() do
		-- get playerName and Group
		local n,r,g = GetRaidRosterInfo(i);
		if n and r and g then
			-- check if group-array exists and create one if needed
			if raidgroup[g] == nil then
				raidgroup[g] = {};
			end			
			-- if player is raid leader or assist, move to top of group
			-- the last assist to be inserted or the first player in the group will be the inviting player
			if r > 0 then 
			    table.insert(raidgroup[g],1,n);
			else 
			    table.insert(raidgroup[g],n);
			end
		end
	end
	return raidgroup;
end

-- disbands the entire raid
local function radisband()
    for i = 1, GetNumGroupMembers() do
    	if UnitName("raid"..i) ~= UnitName("player") then
    		UninviteUnit("raid"..i, L["radisband_message"] .. " " .. UnitName("player"));
		end
	end
	LeaveParty()
end

-- sends the group layout to the chat
local function printGroup(grnum, grp)
	if #grp >= 2 then
		SendChatMessage(L["GROUP"] .. " " .. grnum, "RAID", nil, nil);
		SendChatMessage(L["SPACER"] .. grp[1] .. " " .. L["invites"], "RAID", nil, nil);
		for i = 2, #grp do
			SendChatMessage(L["SPACER"] .. grp[i], "RAID", nil, nil);
		end
	elseif #grp == 1 then
		SendChatMessage(L["GROUP"] .. " " .. grnum, "RAID", nil, nil);
		SendChatMessage(L["SPACER"] .. grp[1], "RAID", nil, nil);	
	end
end

-- sends invite links as whispers to the first member of the group
local function sendInviteLinks(grp)
    if #grp >= 2 then
		for i = 2, #grp do
			SendChatMessage(L["inv"] .. " " .. grp[i], "WHISPER", nil, grp[1]);
			SendChatMessage(L["invite_from"] .. " " .. grp[1], "WHISPER", nil, grp[i]);
		end
	end
end

-- main function
-- parses the raid, disbands,sends invite links
local function raidToGroups(msg)
	if (IsInRaid()) then
		local raidgroup = parseRaid();
		if msg == 'print' then
			if raidgroup ~= nil then
				for i = 1 , #raidgroup, 1 do
					if raidgroup[i] ~= nil then
						printGroup(i, raidgroup[i]);
					end
				end
			end	
		elseif msg == 'disband' then
			radisband();
		elseif msg == 'whisper' then	
			if raidgroup ~= nil then
				-- send whispers
				for i = 1, #raidgroup, 1 do
					if raidgroup[i] ~= nil then
						sendInviteLinks(raidgroup[i]);
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


-- Main operations
SLASH_RAIDTOGROUPS1 = "/raidtogroups";
SLASH_RAIDTOGROUPS2 = "/rtg";

SlashCmdList["RAIDTOGROUPS"] = function(msg)
   raidToGroups(msg);
end 
print(L["welcome_message"]);
