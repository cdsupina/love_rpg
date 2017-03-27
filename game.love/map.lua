--[[
Carlo Supina
www.github.com/cdsupina
cdsupina@gmail.com
]]

Map = {}
Map.__index = Map

setmetatable(Map, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

-- Create new map 
-- @param starting_area The area intended for the player to start on 
function Map:_init(starting_area)
	self.starting_area = starting_area
	self.current_area = starting_area
	self.areas = {}
	self.index = 1
	self.areas[self.index] = starting_area
	self.index = self.index + 1
end

-- Add an area to the map
-- @param area The area to be added to the map
function Map:addArea(area)
	self.areas[self.index] = area
	self.index = self.index + 1
end


-- Set the current area to another area
-- @param index The index of the area to set as the current area
function Map:setCurrentArea(index)
	self.current_area = self.areas[index]
end
