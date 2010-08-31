local addon = select(2, ...)
local view = {}
addon.views["Sets"] = view
view.first = 1

function view:Init()
	addon.window:SetTitle("Selection: Set", .1, .1, .1)
	addon.window:SetBackAction(nil)
end

local detailAction = function(f)
	addon.nav.view = 'Type'
	addon.nav.set = f.id
	addon:RefreshDisplay()
end

local getDuration = function(duration)
	if duration > 60 then
		return format("%im%is", math.floor(duration/60), math.ceil(duration%60))
	else
		return format("%is", math.ceil(duration%60))
	end
end

local setLine = function(lineid, setid, title)
	local set = addon:GetSet(setid)
	local line = addon.window:GetLine(lineid)
	line:SetValues(1, 1)
	if title then
		line:SetLeftText(title)
	else
		line:SetLeftText("%i. %s", setid, set.name)
	end
	if set.start and set.now then
		line:SetRightText("%s  %s", getDuration(set.now-set.start), date("%H:%M", set.start))
	else
		line:SetRightText("")
	end
	line:SetColor(.3, .3, .3)
	line.id = setid
	line:SetDetailAction(detailAction)
	line:Show()
end

function view:Update()
	setLine(0, "total", " Overall Data")
	setLine(1, "current", " Current Fight")

	self.first, self.last = addon:GetArea(self.first, #nMeterCharDB+2)
	if not self.last then return end

	for i = self.first, self.last-2 do
		t = nMeterCharDB[i]
		setLine(i-self.first+2, i)
	end

end
