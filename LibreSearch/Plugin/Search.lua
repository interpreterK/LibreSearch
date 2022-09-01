local Search = {}
Search.__index = Search

local ui, Common = require(script.Parent:WaitForChild("ui")), require(script.Parent:WaitForChild("Common"))
local S, ptrace = Common.S, Common.ptrace

local Selection = S.Selection
local insert, concat, find, remove = table.insert, table.concat, table.find, table.remove
local rgb = Color3.fromRGB
local Results_cout = 0

function Search.new()
    return setmetatable({}, Search)
end

local function DentSpace_Tabs(t_array)
    for t = 1, #t_array do
        if t_array[t] then
            if t_array[t] == '' then
                remove(t_array, find(t_array, t_array[t]))
            elseif t_array[t]:match('%a') then
                break
            end
        end
    end
    return t_array
end

local function Highlight_fuzzy(TextStr, Obtain)
    
end

local function CreateUIelement(Object, LineDetails)
    local Line, Column, Content = LineDetails.Line, LineDetails.Column, LineDetails.Content
    Content = concat(DentSpace_Tabs(Content:split(' ')))

    local TextStr = '<font color="rgb(255,150,0)">'..Line..':'..Column..'</font> - <b>'..Content..'</b>'
    local Result = ui:CreateListItem(Object.ClassName, Object:GetFullName(), TextStr)
    if Object:IsDescendantOf(S.CoreGui) then
        Result.Frame.BackgroundColor3 = rgb(50,50,50)
    end

    Result.SelectInExplorer.MouseButton1Click:Connect(function()
        ptrace(function()
            local Get = Selection:Get()
            insert(Get, Object)
            Selection:Set(Get)
        end)
    end)
    Result.OpenScript.MouseButton1Click:Connect(function()
        ptrace(function()
            Common.plugin:OpenScript(Object, tonumber(Line))
        end)
    end)
end

local function IndexScript(Object, Obtain)
    if Object:IsA("LuaSourceContainer") then
        local Source = tostring(Object.Source)
        local Lines = Source:split('\n')

        for Line = 1, #Lines do
            local c_s, c_e = Lines[Line]:lower():find(Obtain:lower())
            if c_s then
                CreateUIelement(Object, {
                    Content = Lines[Line],
                    Line = Line,
                    Column = c_s
                })
                Results_cout += 1
            end
        end
    end
end

function Search:Index(Obtain)
    Results_cout = 0
    local WSpace = game:GetDescendants()
    for i = 1, #WSpace do
        IndexScript(WSpace[i], Obtain)
    end
    return Results_cout
end

return Search