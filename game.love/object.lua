--[[
Carlo Supina
]]

require 'constants'

Object = {}
Object.__index = Object

setmetatable(Object, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

-- Create new object
-- @param name Name of the object
-- @param image Image to represent the object
-- @param interact The function to execute when the object is enteracted with
function Object:_init(name, image, traverseable, interact)
	self.name = name
	self.image = image
	self.traverseable = traverseable
	self.interact = interact
end

-- Object is examined by the player
function Object:examine()
		print('This is a ' .. self.name)
		self.interact()
end
