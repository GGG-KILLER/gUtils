local list = gUtils.OOP {}
gUtils.Classes.List = list

function list:__construct()
	self.List = { }
end

function list:Set(val, ind)
	self.List[ind] = val
end

function list:Add(val)
	local ind = #self.List + 1

	self.List[ind] = val

	return ind
end

function list:Remove(ind)
	self.List[ind] = nil
end

function list:HasValue(needle)
	for i, val in ipairs(self.List) do
		if val == needle then
			return true
		end
	end

	return false
end

function list:Get(i)
	return self.List[i]
end

function list:Reposition()
	for i = 1, #self.List do
		self.List[i] = self.List[i + 1]
	end
end

function list:Size()
	return gUtils.Table.Count(self.List)
end
