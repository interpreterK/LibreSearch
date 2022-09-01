--[[

]]
local Version = 'r1-()'

local Toolbar = plugin:CreateToolbar("LibreSearch")
local Button = Toolbar:CreateButton("LibreSearch", "Advanced Open Source Search Tool.", 'rbxassetid://8447654914')

local CommonVars, ui = require(script:WaitForChild("Common")), require(script:WaitForChild("ui"))
local S = CommonVars.S

local Window = {
	State = Enum.InitialDockState.Float,
	Enabled = false,
	OverrideRestore = false,
	XSize = 470,
	YSize = 347,
	minWidth = 401,
	minHeight = 205
}
local WindowInfo = DockWidgetPluginGuiInfo.new(Window.State, Window.Enabled, Window.OverrideRestore, Window.XSize, Window.YSize, Window.minWidth, Window.minHeight)
local Window = plugin:CreateDockWidgetPluginGui("Window", WindowInfo)
Window.Title = 'LibreSearch '..Version

local WidgetUi = ui.new(Window)
local BasePanel = WidgetUi:BasePanel()



Button.Click:Connect(function()
	Window.Enabled = not Window.Enabled
end)