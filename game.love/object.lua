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

function Object:_init(name, image, traverseable, interact)
	self.name = name
	self.image = image
	self.traverseable = traverseable
	self.interact = interact
end

--print the name of the object as well as the interact function given in the initialization
function Object:examine()
		print('This is a ' .. self.name)
		self.interact()
end
