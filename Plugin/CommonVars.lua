local Vars = {}
Vars.__index = Vars

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
		pcall(function()
			i[prop] = val
		end)
	end
	i.Parent = Parent
	return i
end

function Vars.write(Var, Func)
	return setmetatable({[Var] = Func}, Vars)
end

return Vars