local addon = nMeter
local view = {}
addon.views["TargetUnits"] = view
view.first = 1

local backAction = function(f)
	view.first = 1
	addon.nav.view = 'Targets'
	addon.nav.target = nil
	addon:RefreshDisplay()
end

function view:Init()
	local set = addon:GetSet(addon.nav.set)
	if not set then backAction() return end
	local target = addon.nav.target
	
	local t = addon.types[addon.nav.type]
	local text = format("%s: %s", t.name, target)
	addon.window:SetTitle(text, t.c[1], t.c[2], t.c[3])
	addon.window:SetBackAction(backAction)
end

local sorttbl = {}
local unitToValue = {}
local sorter = function(u1, u2)
	return unitToValue[u1] > unitToValue[u2]
end

function view:Update(merged)
	local set = addon:GetSet(addon.nav.set)
	if not set then backAction() return end
	local target = addon.nav.target
	local etype = addon.types[addon.nav.type].id
	
	-- compile and sort information table
	local total = 0
	for name,u in pairs(set.unit) do
		if u[etype] and u[etype].target and u[etype].target[target] then
			total = total + u[etype].target[target]
			local ou = merged and u.owner and set.unit[u.owner] or u
			if unitToValue[ou] then
				unitToValue[ou] = unitToValue[ou] + u[etype].target[target]
			else
				unitToValue[ou] = u[etype].target[target]
				tinsert(sorttbl, ou)
			end
		end
	end
	table.sort(sorttbl, sorter)
	
	-- display
	self.first, self.last = addon:GetArea(self.first, #sorttbl)
	if not self.last then return end
	
	local maxvalue = unitToValue[sorttbl[1]]
	for i = self.first, self.last do
		local u = sorttbl[i]
		local value = unitToValue[u]
		local c = addon.color[u.class]
		
		local line = addon.window:GetLine(i-self.first)
		line:SetValues(value, maxvalue)
		if u.owner then
			line:SetLeftText("%i. %s <%s>", i, u.name, u.owner)
		else
			line:SetLeftText("%i. %s", i, u.name)
		end
		line:SetRightText("%i (%02.1f%%)", value, value/total*100)
		line:SetColor(c[1], c[2], c[3])
		line:SetDetailAction(nil)
		line:Show()
	end
	
	sorttbl = wipe(sorttbl)
	unitToValue = wipe(unitToValue)
end