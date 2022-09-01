local ui = {
	Ui_objs = {},
	Queues = {}
}
ui.__index = ui

local CommonVars = require(script.Parent:WaitForChild("Common"))
local New, Remove = CommonVars.New, CommonVars.Remove

local V2, UD2_s, UD, UD2 = Vector2.new, UDim2.fromScale, UDim.new, UDim2.new
local C3, rgb, hex = Color3.new, Color3.fromRGB, Color3.fromHex
local insert = table.insert

local Class_icons = {
	Script = 'rbxassetid://46342657',
	LocalScript = 'rbxassetid://2254538713',
	ModuleScript = 'rbxassetid://5016313061'
}
local Color_holder = {
	white = C3(1,1,1),
	black = C3(0,0,0),
	deadbeef = 0xDEADBEEF,
	beefbabe = 0xBEEFBABE
}
local V2_Center = V2(.5,.5)

function ui.new(Widget)
	return setmetatable({Widget = Widget}, ui)
end

function ui:BasePanel()
	assert(self.Widget, 'BasePanel does not have a Widget element')

	self.Ui_objs.MainPanel = New('Frame', self.Widget, {
		Name = 'MainPanel',
		AnchorPoint = V2_Center,
		BackgroundColor3 = Color_holder.black,
		Position = UD2_s(.5,.5),
		Size = UD2_s(1,1.250),
	})
	self.Ui_objs.OptionsPanel = New('Frame', self.Ui_objs.MainPanel, {
		Name = 'OptionsPanel',
		AnchorPoint = V2_Center,
		BackgroundColor3 = rgb(25,25,25),
		BorderColor3 = rgb(45,45,45),
		BorderSizePixel = 2,
		Position = UD2_s(.855,.499),
		Size = UD2_s(.272,.761),
	})
	self.Ui_objs.ResultsField = New('ScrollingFrame', self.Ui_objs.MainPanel, {
		Name = 'ResultsField',
		AnchorPoint = V2_Center,
		BackgroundColor3 = rgb(50,50,50),
		BorderColor3 = rgb(45,45,45),
		BorderSizePixel = 0,
		Position = UD2_s(.359,.516),
		Size = UD2_s(.7,.642),
		CanvasSize = UD2(0,0,0,0),
		ScrollBarThickness = 7,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		BottomImage = 'rbxassetid://5255459942',
		MidImage = 'rbxassetid://4710023238',
		TopImage = 'rbxassetid://4710022881',
	})
	self.Ui_objs.UIListLayout = New('UIListLayout', self.Ui_objs.ResultsField, {
		Padding = UD(0,0),
	})
	self.Ui_objs.SearchButton = New('TextButton', self.Ui_objs.MainPanel, {
		Name = 'Search',
		Text = 'Search...',
		Font = Enum.Font.Ubuntu,
		TextScaled = true,
		AnchorPoint = V2(.5,.5,.5),
		TextColor3 = C3(1,1,1),
		BackgroundColor3 = rgb(75,75,75),
		BorderColor3 = Color_holder.black,
		Position = UD2_s(.629,.145),
		Size = UD2_s(.159,.054),
	})
	self.Ui_objs.SearchField = New('TextBox', self.Ui_objs.MainPanel, {
		Name = 'SearchField',
		PlaceholderText = 'Find...',
		Text = '',
		Font = Enum.Font.Code,
		AnchorPoint = V2_Center,
		BackgroundColor3 = rgb(45,45,45),
		BorderColor3 = Color_holder.black,
		PlaceholderColor3 = rgb(178,178,178),
		TextColor3 = Color_holder.white,
		TextScaled = true,
		ClearTextOnFocus = false,
		Position = UD2_s(.276,.146),
		Size = UD2_s(.534,.053),
	})
	self.Ui_objs.Results = New('TextLabel', self.Ui_objs.MainPanel, {
		Name = 'Results',
		Text = 'Results: 0',
		Font = Enum.Font.Code,
		TextScaled = true,
		AnchorPoint = V2_Center,
		BackgroundTransparency = 1,
		Position = UD2_s(.074,.867),
		Size = UD2_s(.131,.043),
		TextColor3 = Color_holder.white,
	})
	self.Ui_objs.OptionsTitle = New('TextLabel', self.Ui_objs.OptionsPanel, {
		Name = 'OptionsTitle',
		Text = 'Options',
		TextScaled = true,
		Font = Enum.Font.Ubuntu,
		AnchorPoint = V2_Center,
		TextColor3 = Color_holder.white,
		BackgroundColor3 = rgb(51,51,51),
		Position = UD2_s(.502,.041),
		Size = UD2_s(.95,.055),
	})
	self.Ui_objs.UICorner = New('UICorner', self.Ui_objs.OptionsTitle, {
		CornerRadius = UD(0,8)
	})
	self.Ui_objs.NoResults = New('TextLabel', self.Ui_objs.MainPanel, {
		Name = 'NoResults',
		Text = 'No Results To Display.',
		TextScaled = true,
		Font = Enum.Font.Ubuntu,
		AnchorPoint = V2_Center,
		TextColor3 = Color_holder.white,
		BackgroundTransparency = 1,
		Position = UD2_s(.358,.499),
		Size = UD2_s(.255,.089)
	})

	return self.Ui_objs
end

function ui:CreateListItem(ScriptType, Path, QueueDetails)
	assert(self.Ui_objs.Panel)

	local Queue = {}
	Queue.Frame = New('Frame', self.Ui_objs.ResultsField, {
		Name = 'Result',
		BackgroundColor3 = rgb(0,75,36),
		BorderColor3 = Color_holder.white,
		Size = UD2_s(1,.05),
		BorderSizePixel = 5,
	})
	Queue.ImageLabel = New('ImageLabel', Queue.Frame, {
		Image = Class_icons[ScriptType],
		ScaleType = Enum.ScaleType.Fit,
		AnchorPoint = V2_Center,
		Position = UD2_s(.218,.031),
		Size = UD2_s(.031,0379),
		BackgroundTransparency = 1,
	})
	Queue.OpenScript = New('TextButton', Queue.Frame, {
		Name = 'OpenScript',
		Text = 'Open Script',
		TextColor3 = Color_holder.white,
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		AnchorPoint = V2_Center,
		BackgroundColor3 = rgb(15,128,255),
		Position = UD2_s(.863,.687),
		Size = UD2_s(.237,.431),
		BorderSizePixel = 0,
	})
	Queue.SelectInExplorer = New('TextButton', Queue.Frame, {
		Name = 'SelectScript',
		Text = 'Select In Explorer',
		TextColor3 = Color_holder.white,
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		AnchorPoint = V2_Center,
		BackgroundColor3 = rgb(253,102,102),
		Position = UD2_s(.863,.278),
		Size = UD2_s(.237,.398),
		BorderSizePixel = 0,
	})
	Queue.Path = New('TextLabel', Queue.Frame, {
		Text = Path,
		Name = 'Path',
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		AnchorPoint = V2_Center,
		BackgroundTransparency = 1,
		TextColor3 = Color_holder.white,
		Position = UD2_s(.392,.204),
		Size = UD2_s(.706,.333),
	})
	Queue.FoundInfo = New('TextLabel', Queue.Frame, {
		Text = QueueDetails,
		Font = Enum.Font.Code,
		TextColor3 = Color_holder.white,
		TextScaled = true,
		BackgroundTransparency = 1,
		AnchorPoint = V2_Center,
		Position = UD2_s(.373,.71),
		Size = UD2_s(.745,.333),
	})

	insert(self.Queues, Queue.Frame)
	return Queue
end

function ui:ClearSearchQueue()
	for i = 1, #self.Queues do
		Remove(self.Queues[i])
	end
end

return ui