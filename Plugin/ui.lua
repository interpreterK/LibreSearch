local ui = {}
ui.__index = ui

local CommonVars = require(script.Parent:WaitForChild("CommonVars"))
local New = CommonVars.New

local V2, UD2_s = Vector2.new, UDim2.fromScale
local C3 = Color3.new

local function ImageType(Scontainer)
	return Scontainer.ClassName == "Script" and 'rbxassetid://46342657' or
	Scontainer.ClassName == "LocalScript" and 'rbxassetid://2254538713' or
	Scontainer.ClassName == "ModuleScript" and 'rbxassetid://5016313061'
end

function ui.new(Widget)
	return setmetatable({Widget = Widget}, ui)
end

function ui:BasePanel()
	assert(self.Widget, 'BasePanel does not have a Widget element')

	--local ScreenGui = New('ScreenGui', self.Widget)
	local Panel = New('Frame', self.Widget, {
		Name = 'MainPanel',
		AnchorPoint = V2(.5,.5),
		BackgroundColor3 = C3(0,0,0),
		Position = UD2_s(.5,.5),
		Size = UD2_s(1,1.250)
	})
	return {
		ScreenGui = ScreenGui,
		Panel = Panel
	}
end

function ui:

return ui