local Vars = {}
Vars.__index = Vars

Vars.ptrace = function(func)
	local b,e = pcall(func)
	if not b then
		warn(e, debug.traceback())
	end
end

Vars.S = setmetatable({}, {
	__index = function(self,i)
		if not rawget(self,i) then
			self[i] = game:GetService(i)
		end
		return rawget(self,i)
	end
})

Vars.New = function(Inst, Parent, Props)
	local i = Instance.new(Inst)
	for prop, val in next, Props or {} do
		Vars.ptrace(function()
			i[prop] = val
		end)
	end
	i.Parent = Parent
	return i
end

Vars.Remove = function(Inst)
	Vars.ptrace(function()
		Inst:Destroy()
	end)
end

Vars.Enter_Leave = function(gui)
	gui.MouseEnter:Connect(function()
		Vars.ptrace(function()
			Vars.plugin:GetMouse().Icon = 'rbxasset://SystemCursors/PointingHand'
		end)
	end)
	gui.MouseLeave:Connect(function()
		Vars.ptrace(function()
			Vars.plugin:GetMouse().Icon = 'rbxasset://SystemCursors/Arrow'
		end)
	end)
end

function Vars.write(array)
	for i,v in next, array do
		Vars[i] = v
	end
end

return Vars