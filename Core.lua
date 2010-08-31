local addonname, addon = ...
addon.events = CreateFrame("Frame")
addon.events:SetScript("OnEvent", function(self, event, ...)
	addon[event](addon, event, ...)
end)
addon.views = {}
-- important GUIDs
addon.guidToClass = {}
addon.guidToName = {}

-- SETTINGS
local s = {
	refreshinterval = 1,
	mincombatlength = 15,
	combatseconds = 3,
}
-- available types and their order
addon.types = {
	{
		name = "Damage",
		id = "dd",
		c = {.25, .66, .35},
	},
	{
		name = "Damage Targets",
		id = "dd",
		view = "Targets",
		onlyfights = true,
		c = {.25, .66, .35},
	},
	{
		name = "Damage Taken: Targets",
		id = "dt",
		view = "Targets",
		onlyfights = true,
		c = {.66, .25, .25},
	},
	{
		name = "Damage Taken: Abilities",
		id = "dt",
		view = "Spells",
		c = {.66, .25, .25},
	},
	{
		name = "Friendly Fire",
		id = "ff",
		c = {.63, .58, .24},
	},
	{
		name = "Healing + Absorbs",
		id = "hd",
		id2 = "ga",
		c = {.25, .5, .85},
	},
--	{
--		name = "Healing",
--		id = "hd",
--		c = {.25, .5, .85},
--	},
--	{
--		name = "Guessed Absorbs",
--		id = "ga",
--		c = {.25, .5, .85},
--	},
	{
		name = "Overhealing",
		id = "oh",
		c = {.25, .5, .85},
	},
	{
		name = "Dispels",
		id = "dp",
		c = {.58, .24, .63},
	},
	{
		name = "Interrupts",
		id = "ir",
		c = {.09, .61, .55},
	},
	{
		name = "Power Gains",
		id = "mg",
		c = {48/255, 113/255, 191/255},
	},
	{
		name = "Death Log",
		id = "deathlog",
		view = "Deathlog",
		onlyfights = true,
		c = {.66, .25, .25},
	},
}

local bossIds = {
	-- Naxxramas
	[15956] = true, -- Anub'Rekhan
	[15953] = true, -- Grand Widow Faerlina
	[15952] = true, -- Maexxna
	[15954] = true, -- Noth the Plaguebringer
	[15936] = true, -- Heigan the Unclean
	[16011] = true, -- Loatheb
	[16061] = true, -- Instructor Razuvious
	[16060] = true, -- Gothik the Harvester
	[16064] = "The Four Horsemen", -- Thane Korth'azz
	[16065] = "The Four Horsemen", -- Lady Blaumeux
	[30549] = "The Four Horsemen", -- Baron Rivendare
	[16063] = "The Four Horsemen", -- Sir Zeliek
	[16028] = true, -- Patchwerk
	[15931] = true, -- Grobbulus
	[15932] = true, -- Gluth
	[15928] = true, -- Thaddius
	[15989] = true, -- Sapphiron
	[15990] = true, -- Kel'Thuzad
	-- The Eye of Eternity
	[28859] = true, -- Malygos
	-- The Obsidian Sanctum
	[28860] = true, -- Sartharion
	-- Vault of Archavon
	[31125] = true, -- Archavon the Stone Watcher
	[33993] = true, -- Emalon the Storm Watcher
	[35013] = true, -- Koralon the Flame Watcher
	[38433] = true, -- Toravon the Ice Watcher
	-- Ulduar
	[33113] = true, -- Flame Leviathan
	[33118] = true, -- Ignis the Furnace Master
	[33186] = true, -- Razorscale
	[33293] = true, -- XT-002 Deconstructor
	[32867] = "Assembly of Iron", -- Steelbreaker
	[32927] = "Assembly of Iron", -- Runemaster Molgeim
	[32857] = "Assembly of Iron", -- Stormcaller Brundir
	[32930] = true, -- Kologarn
	[33515] = true, -- Auriaya
	[32906] = true, -- Freya
	[32845] = true, -- Hodir
	[33432] = "Mimiron", -- Leviathan Mk II
	[33651] = "Mimiron", -- VX-001
	[33670] = "Mimiron", -- Aerial Command Unit
	[32865] = true, -- Thorim
	[33271] = true, -- General Vezax
	[33136] = "Yogg-Saron", -- Guardian of Yogg-Saron
	[33288] = true, -- Yogg-Saron
	[32871] = true, -- Algalon the Observer
	-- Trial of the Crusader
	[34796] = "Northrend Beasts", -- Gormok the Impaler
	[35144] = "Northrend Beasts", -- Acidmaw
	[34799] = "Northrend Beasts", -- Dreadscale
	[34797] = "Northrend Beasts", -- Icehowl
	[34780] = true, -- Lord Jaraxxus
	[34469] = "Faction Champions", -- Melador Valestrider <Druid>
	[34459] = "Faction Champions", -- Erin Misthoof <Druid>
	[34465] = "Faction Champions", -- Velanaa <Paladin>
	[34445] = "Faction Champions", -- Liandra Suncaller <Paladin>
	[34466] = "Faction Champions", -- Anthar Forgemender <Priest>
	[34447] = "Faction Champions", -- Caiphus the Stern <Priest>
	[34470] = "Faction Champions", -- Saamul <Shaman>
	[34444] = "Faction Champions", -- Thrakgar <Shaman>
	[34497] = "Twin Val'kyr", -- Fjola Lightbane
	[34496] = "Twin Val'kyr", -- Eydis Darkbane
	[34564] = true, -- Anub'arak
	-- Onyxia's Lair
	[10184] = true, -- Onyxia
	-- Icecrown Citadel
	[36612] = true, -- Lord Marrowgar
	[36855] = true, -- Lady Deathwhisper
	[37813] = true, -- Deathbringer Saurfang
	[36626] = true, -- Festergut
	[36627] = true, -- Rotface
	[36678] = true, -- Professor Putricide
	[37972] = "Blood Prince Council", -- Prince Keleseth
	[37973] = "Blood Prince Council", -- Prince Taldaram
	[37970] = "Blood Prince Council", -- Prince Valanar
	[37955] = true, -- Blood-Queen Lana'thel
	[37868] = "Valithria Dreamwalker", -- Risen Archmage
	[36853] = true, -- Sindragosa
	[36597] = true, -- The Lich King
	-- Ruby Sanctum
	[39863] = true, -- Halion
}

-- used colors
addon.color = {
	HUNTER = { 0.67, 0.83, 0.45 },
	WARLOCK = { 0.58, 0.51, 0.79 },
	PRIEST = { 1.0, 1.0, 1.0 },
	PALADIN = { 0.96, 0.55, 0.73 },
	MAGE = { 0.41, 0.8, 0.94 },
	ROGUE = { 1.0, 0.96, 0.41 },
	DRUID = { 1.0, 0.49, 0.04 },
	SHAMAN = { 0.14, 0.35, 1.0 },
	WARRIOR = { 0.78, 0.61, 0.43 },
	DEATHKNIGHT = { 0.77, 0.12, 0.23 },
	PET = { 0.09, 0.61, 0.55 },
}
addon.colorhex = {}
do
	for class, c in pairs(addon.color) do
		addon.colorhex[class] = string.format("%02X%02X%02X", c[1] * 255, c[2] * 255, c[3] * 255)
	end
end

addon.spellIcon = setmetatable({ [0] = "", [75] = "", }, { __index = function(tbl, i)
	local spell, _, icon = GetSpellInfo(i)
	addon.spellName[i] = spell
	tbl[i] = icon
	return icon
end})
addon.spellName = setmetatable({ [0] = "Melee", }, {__index = function(tbl, i)
	local spell, _, icon = GetSpellInfo(i)
	addon.spellIcon[i] = icon
	tbl[i] = spell
	return spell
end})
local newSet = function()
	return {
		unit = {},
	}
end
local current

local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Numeration", {
	type = "data source",
	text = "Numeration",
	icon = [[Interface\Icons\Ability_Warrior_WeaponMastery]],
})
local icon = LibStub("LibDBIcon-1.0")

addon.events:RegisterEvent("ADDON_LOADED")
function addon:ADDON_LOADED(event, addon)
	if addon ~= addonname then return end
	self.events:UnregisterEvent("ADDON_LOADED")
	
	self:InitOptions()
	icon:Register("Numeration", ldb, NumerationCharOptions.minimap)
	self.window:OnInitialize()
	if NumerationCharOptions.forcehide then
		self.window:Hide()
	end
	
	if not NumerationCharDB then
		self:Reset()
	end
	current = self:GetSet(1) or newSet()
	
	self.events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	if GetRealZoneText() ~= "" then
		self:ZONE_CHANGED_NEW_AREA(event)
	end
end

function addon:InitOptions()
	if not NumerationCharOptions then
		NumerationCharOptions = {}
	end
	if NumerationCharOptions.keeponlybosses == nil then
		NumerationCharOptions.keeponlybosses = true
	end
	if NumerationCharOptions.petsmerged == nil then
		NumerationCharOptions.petsmerged = true
	end
	if NumerationCharOptions.onlyinstance == nil then
		NumerationCharOptions.onlyinstance = true
	end
	if NumerationCharOptions.deathlog == nil then
		NumerationCharOptions.deathlog = true
	end
	if not NumerationCharOptions.minimap then
		NumerationCharOptions.minimap = {
			hide = false,
		}
	end
	if not NumerationCharOptions.nav then
		NumerationCharOptions.nav = {
			view = 'Units',
			set = 'current',
			type = 1,
		}
	end
	self.nav = NumerationCharOptions.nav
end

function ldb:OnTooltipShow()
    GameTooltip:AddLine("Numeration", 1, .8, 0)
    GameTooltip:AddLine("Left-Click to toggle window visibility.")
    GameTooltip:AddLine("Shift + Left-Click to reset data.")
end

function ldb:OnClick(button)
	if button == "LeftButton" then
		if IsShiftKeyDown() then
			addon.window:ShowResetWindow()
		else
			NumerationCharOptions.forcehide = not NumerationCharOptions.forcehide
			if NumerationCharOptions.forcehide then
				addon.window:Hide()
			else
				addon.window:Show()
				addon:RefreshDisplay()
			end
		end
	end
end

function addon:MinimapIconShow(show)
	NumerationCharOptions.minimap.hide = not show
	if show then
		icon:Show("Numeration")
	else
		icon:Hide("Numeration")
	end
end

function addon:SetOption(option, value)
	NumerationCharOptions[option] = value
	if option == "onlyinstance" then
		self:ZONE_CHANGED_NEW_AREA(true)
	elseif option == "petsmerged" then
		self:RefreshDisplay(true)
	end
end

function addon:GetOption(option)
	return NumerationCharOptions[option]
end

function addon:Reset()
	local lastZone = NumerationCharDB and NumerationCharDB.zone
	NumerationCharDB = {
		[0] = newSet(),
		zone = lastZone,
	}
	NumerationCharDB[0].name = "Overall"
	current = newSet()
	if self.nav.set and self.nav.set ~= "total" and self.nav.set ~= "current" then
		self.nav.set = "current"
	end
	self:RefreshDisplay()
	collectgarbage("collect")
end

local updateTimer = CreateFrame("Frame")
updateTimer:Hide()
updateTimer:SetScript("OnUpdate", function(self, elapsed)
	self.timer = self.timer - elapsed
	if self.timer > 0 then return end
	self.timer = s.refreshinterval
	
	if not addon.nav.set then return end
	
	if current.changed then
		ldb.text = addon.views["Units"]:GetXps(current, UnitName("player"), "dd", NumerationCharOptions.petsmerged)
	end
	
	local set = addon:GetSet(addon.nav.set)
	if not set or not set.changed then
		return
	end
	set.changed = nil
	
	addon:RefreshDisplay(true)
end)
function updateTimer:Activate()
	self.timer = s.refreshinterval
	self:Show()
end
function updateTimer:Refresh()
	self.timer = s.refreshinterval
end

function addon:RefreshDisplay(update)
	if self.window:IsShown() then
		self.window:Clear()
		
		if not update then
			self.views[self.nav.view]:Init()
			local segment = self.nav.set == 'total' and "O" or self.nav.set == 'current' and "C" or self.nav.set
			self.window:UpdateSegment(segment)
		end
		self.views[self.nav.view]:Update(NumerationCharOptions.petsmerged)
	end
	if not update then
		ldb.text = self.views["Units"]:GetXps(current, UnitName("player"), "dd", NumerationCharOptions.petsmerged)
	end
	
	updateTimer:Refresh()
end

local useChatType, useChannel
function addon:Report(lines, chatType, channel)
	useChatType, useChannel = chatType, channel
	if channel == "target" then
		useChannel = UnitName("target")
		if not useChannel or not UnitIsPlayer(useChannel) or not UnitCanCooperate("player", useChannel) then
			print("Invalid or no target selected")
			return
		end
	end
	local view = self.views[self.nav.view]
	if view.Report then
		view:Report(NumerationCharOptions.petsmerged, lines)
	else
		print("Report is not supported by '", self.nav.view, "'-view")
	end
end

function addon:PrintHeaderLine(set)
	local datetext, timetext = self:GetDuration(set)
	self:PrintLine("# %s for %s%s", self.window:GetTitle(), set.name, datetext and format(" [%s %s]", datetext, timetext) or "")
end

function addon:PrintLine(...)
	SendChatMessage(format(...), useChatType, nil, useChannel)
end

function addon:Scroll(dir)
	local view = self.views[self.nav.view]
	if dir > 0 and view.first > 1 then
		if IsShiftKeyDown() then
			view.first = 1
		else
			view.first = view.first - 1
		end
	elseif dir < 0 then
		if IsShiftKeyDown() then
			view.first = 9999
		else
			view.first = view.first + 1
		end
	end
	self:RefreshDisplay(true)
end

function addon:GetArea(start, total)
	if total == 0 then return start end
	
	local first = start
	local last = start+self.window.maxlines-1
	if last > total then
		first = first-last+total
		last = total
	end
	if first < 1 then
		first = 1
	end
	self.window:SetScrollPosition(first, total)
	return first, last
end

function addon:GetSet(id)
	if not id then return end
	
	if id == 'current' then
		return current
	elseif id == 'total' then
		id = 0
	end
	return NumerationCharDB[id]
end

function addon:GetSets()
	return NumerationCharDB[0], current.active and current
end

function addon:GetDuration(set)
	if not set.start or not set.now then return end
	local duration = math.ceil(set.now-set.start)
	local durationtext = duration < 60 and format("%is", duration%60) or format("%im%is", math.floor(duration/60), duration%60)
	return date("%H:%M", set.start), durationtext
end

function addon:GetUnitClass(playerID)
	if not playerID then return end
	
	local class = self.guidToClass[playerID]
	if self.guidToName[class] then
		return "PET"
	end
	return class
end

function addon:GetUnit(set, playerID, playerName)
	local class = self.guidToClass[playerID]
	local ownerName = self.guidToName[class]
	if not playerName then
		playerName = self.guidToName[playerID]
	end
	
	if not ownerName then
		-- unit
		local u = set.unit[playerName]
		if not u then
			u = {
				name = playerName,
				class = class,
			}
			set.unit[playerName] = u
		end
		return u
	else
		-- pet
		local name = format("%s:%s", ownerName, playerName)
		local p = set.unit[name]
		if not p then
			local ownertable = self:GetUnit(set, class, ownerName)
			if not ownertable.pets then
				ownertable.pets = {}
			end
			ownertable.pets[name] = true

			p = {
				name = playerName,
				class = "PET",
				owner = ownerName,
			}
			set.unit[name] = p
		end
		return p, true
	end
end

local summonguids = {}
do
	local UnitGUID, UnitName, UnitClass
		= UnitGUID, UnitName, UnitClass
	local addPlayerPet = function(unit, pet)
		local unitID = UnitGUID(unit)
		if not unitID then return end
		
		local unitName, unitRealm = UnitName(unit)
		local _, unitClass = UnitClass(unit)
		local petID = UnitGUID(pet)
		
		addon.guidToClass[unitID] = unitClass
		addon.guidToName[unitID] = unitRealm and format("%s-%s", unitName, unitRealm) or unitName
		if petID then
			addon.guidToClass[petID] = unitID
		end
	end
	function addon:UpdateGUIDS()
		self.guidToName = wipe(self.guidToName)
		self.guidToClass = wipe(self.guidToClass)
		for pid, uid in pairs(summonguids) do
			self.guidToClass[pid] = uid
		end
		
		local num = GetNumRaidMembers()
		if num > 0 then
			for i = 1, num do
				addPlayerPet("raid"..i, "raid"..i.."pet")
			end
		else
			addPlayerPet("player", "pet")
			local num = GetNumPartyMembers()
			if num > 0 then
				for i = 1, num do
					addPlayerPet("party"..i, "party"..i.."pet")
				end
			end
		end
		
		-- remove summons from guid list, if owner is gone
		for pid, uid in pairs(summonguids) do
			if not self.guidToClass[uid] then
				self.guidToClass[pid] = nil
				summonguids[pid] = nil
			end
		end
		self:GUIDsUpdated()
	end
end
addon.PLAYER_ENTERING_WORLD = addon.UpdateGUIDS
addon.PARTY_MEMBERS_CHANGED = addon.UpdateGUIDS
addon.RAID_ROSTER_UPDATE = addon.UpdateGUIDS
addon.UNIT_PET = addon.UpdateGUIDS
function addon:ZONE_CHANGED_NEW_AREA(force)
	local _, zoneType = IsInInstance()

	if force == true or zoneType ~= self.zoneType then
		self.zoneType = zoneType
		
		if not NumerationCharOptions.onlyinstance or zoneType == "party" or zoneType == "raid" then
			local curZone = GetRealZoneText()
			if curZone ~= NumerationCharDB.zone then
				NumerationCharDB.zone = curZone
				addon.window:ShowResetWindow()
			end
			self:UpdateGUIDS()
			
			self.events:RegisterEvent("PLAYER_ENTERING_WORLD")
			self.events:RegisterEvent("PARTY_MEMBERS_CHANGED")
			self.events:RegisterEvent("RAID_ROSTER_UPDATE")
			self.events:RegisterEvent("UNIT_PET")
			
			self.events:RegisterEvent("PLAYER_REGEN_DISABLED")
			self.events:RegisterEvent("PLAYER_REGEN_ENABLED")
			
			self.events:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			
			updateTimer:Activate()
			if not NumerationCharOptions.forcehide then
				self:RefreshDisplay()
				self.window:Show()
			end
		else
			self.events:UnregisterEvent("PLAYER_ENTERING_WORLD")
			self.events:UnregisterEvent("PARTY_MEMBERS_CHANGED")
			self.events:UnregisterEvent("RAID_ROSTER_UPDATE")
			self.events:UnregisterEvent("UNIT_PET")
			
			self.events:UnregisterEvent("PLAYER_REGEN_DISABLED")
			self.events:UnregisterEvent("PLAYER_REGEN_ENABLED")
			
			self.events:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			updateTimer:Hide()
			if zoneType == "none" then
				if not NumerationCharOptions.forcehide then
					self:RefreshDisplay()
					self.window:Show()
				end
			else
				self.window:Hide()
			end
		end
	end
end

local inCombat = nil
local combatTimer = CreateFrame("Frame")
combatTimer:Hide()
combatTimer:SetScript("OnUpdate", function(self, elapsed)
	self.timer = self.timer - elapsed
	if self.timer > 0 then return end
	addon:LeaveCombatEvent()
	self:Hide()
end)
function combatTimer:Activate()
	self.timer = s.combatseconds
	self:Show()
end
function addon:PLAYER_REGEN_DISABLED()
	inCombat = true
	combatTimer:Hide()
end
function addon:PLAYER_REGEN_ENABLED()
	inCombat = nil
	combatTimer:Activate()
end

function addon:EnterCombatEvent(timestamp, guid, name)
	if not current.active then
		current = newSet()
		current.start = timestamp
		current.active = true
	end
	
	current.now = timestamp
	if not current.boss then
		local mobid = bossIds[tonumber(guid:sub(9, 12), 16)]
		if mobid then
			current.name = mobid == true and name or mobid
			current.boss = true
		elseif not current.name then
			current.name = name
		end
	end
	if not inCombat then
		combatTimer:Activate()
	end
end

function addon:LeaveCombatEvent()
	if current.active then
		current.active = nil
		if ((current.now - current.start) < s.mincombatlength) or (NumerationCharOptions.keeponlybosses and not current.boss) then
			return
		end
		tinsert(NumerationCharDB, 1, current)
		if type(self.nav.set) == "number" then
			self.nav.set = self.nav.set + 1
		end
		
		-- Refresh View
		self:RefreshDisplay(true)
	end
end

function addon:COMBAT_LOG_EVENT_UNFILTERED(e, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if self.collect[eventtype] then
		self.collect[eventtype](timestamp, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	end

	local ownerClassOrGUID = self.guidToClass[srcGUID]
	if eventtype == 'SPELL_SUMMON' and ownerClassOrGUID then
		local realSrcGUID = self.guidToClass[ownerClassOrGUID] and ownerClassOrGUID or srcGUID
		summonguids[dstGUID] = realSrcGUID
		self.guidToClass[dstGUID] = realSrcGUID
	elseif eventtype == 'UNIT_DIED' and summonguids[srcGUID] then
		summonguids[srcGUID] = nil
		self.guidToClass[srcGUID] = nil
	end
end