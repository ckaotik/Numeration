local addon = nMeter
local view = {}
addon.views["Spells"] = view
view.first = 1

local backAction = function(f)
	view.first = 1
	addon.nav.view = 'Type'
	addon.nav.type = nil
	addon:RefreshDisplay()
end

local detailAction = function(f)
	addon.nav.view = 'SpellUnits'
	addon.nav.spell = f.spell
	addon:RefreshDisplay()
end

function view:Init()
	local v = nMeter.types[addon.nav.type]
	local c = v.c
	addon.window:SetTitle(v.name, c[1], c[2], c[3])
	addon.window:SetBackAction(backAction)
end

local sorttbl = {}
local spellToValue = {}
local sorter = function(s1, s2)
	return spellToValue[s1] > spellToValue[s2]
end

local spellName = addon.spellName
local spellIcon = addon.spellIcon
function view:Update(merged)
	local set = addon:GetSet(addon.nav.set)
	if not set then return end
	local etype = addon.types[addon.nav.type].id
	
	-- compile and sort information table
	local total = 0
	for name,u in pairs(set.unit) do
		if u[etype] then
			total = total + u[etype].total
			for id,amount in pairs(u[etype].spell) do
				if spellToValue[id] then
					spellToValue[id] = spellToValue[id] + amount
				else
					spellToValue[id] = amount
					tinsert(sorttbl, id)
				end
			end
		end
	end
	table.sort(sorttbl, sorter)
	
	-- display
	self.first, self.last = addon:GetArea(self.first, #sorttbl)
	if not self.last then return end
	
	local c = addon.types[addon.nav.type].c
	local maxvalue = spellToValue[sorttbl[1]]
	for i = self.first, self.last do
		local id = sorttbl[i]
		local value = spellToValue[id]
		local name, icon = spellName[id], spellIcon[id]
		
		if id == 0 or id == 75 then icon = "" end
		
		local line = addon.window:GetLine(i-self.first)
		line:SetValues(value, maxvalue)
		line:SetLeftText("%i. %s", i, name)
		line:SetRightText("%i (%02.1f%%)", value, value/total*100)
		line:SetColor(c[1], c[2], c[3])
		line:SetIcon(icon)
		line.spell = id
		line:SetDetailAction(detailAction)
		line:Show()
	end
	
	sorttbl = wipe(sorttbl)
	spellToValue = wipe(spellToValue)
end