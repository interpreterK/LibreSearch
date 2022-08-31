--[[

]]
local Version = 'r1-()'

local Toolbar = plugin:CreateToolbar("LibreSearch")
local Button = Toolbar:CreateButton("LibreSearch", "Advanced Open Source Search Tool.", 'rbxassetid://8447654914')

local CommonVars, ui = require(script:WaitForChild("Common")), require(script:WaitForChild("ui"))
local S = CommonVars.S

local WindowInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 750, 245, 401, 205)
local Window = plugin:CreateDockWidgetPluginGui("Window", WindowInfo)
Window.Title = 'LibreSearch '..Version

local WidgetUi = ui.new(Window)
local BasePanel = WidgetUi:BasePanel()

Button.Click:Connect(function()
	Window.Enabled = not Window.Enabled
end)