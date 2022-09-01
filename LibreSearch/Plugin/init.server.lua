--[[

]]
local Version = 'r1-()'

local Toolbar = plugin:CreateToolbar("LibreSearch")
local Button = Toolbar:CreateButton("LibreSearch", "Advanced Open Source Search Tool.", 'rbxassetid://8447654914')

local Common, ui, Search = require(script:WaitForChild("Common")), require(script:WaitForChild("ui")), require(script:WaitForChild("Search"))
Common.write({plugin = plugin})

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

--Ui Connections
local SearchField = BasePanel.SearchField
local SearchButton = BasePanel.SearchButton
local NoResults = BasePanel.NoResults
local Results = BasePanel.Results

local function Start_SearchIndex(KWord)
	SearchButton.Text = '...' --Some kind of indicator that the search is in progress
	ui:ClearSearchQueue()

	local newSearch = Search.new()
	local Results_cout = newSearch:Index(KWord)
	SearchButton.Text = 'Search...'

	NoResults.Visible = Results_cout == 0
	Results.Text = 'Results: '..tostring(Results_cout)
end

SearchField.FocusLost:Connect(function(enter)
	if enter then
		Start_SearchIndex(SearchField.Text)
	end
end)
SearchButton.MouseButton1Click:Connect(function()
	Start_SearchIndex(SearchField.Text)
end)

Button.Click:Connect(function()
	Window.Enabled = not Window.Enabled
end)