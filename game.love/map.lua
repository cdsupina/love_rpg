Map = {}
Map.__index = Map

setmetatable(Map, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

--map contains indexed areas
function Map:_init(starting_area)
	self.starting_area = starting_area
	self.current_area = starting_area
	self.areas = {}
	self.index = 1
	self.areas[self.index] = starting_area
	self.index = self.index + 1
end

--adds area to the map in the next index
function Map:addArea(area)
	self.areas[self.index] = area
	self.index = self.index + 1
end


--sets current area to the requested index
function Map:setCurrentArea(index)
	self.current_area = self.areas[index]
end


