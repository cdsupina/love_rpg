require 'AnAL'
require 'constants'

Tile = {}
Tile.__index = Tile

setmetatable(Tile, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

function Tile:_init(name ,image, traverseable)
	self.image = image
	self.traverseable = traverseable
	self.tile_type = 'static'
	self.animated = false
	self.name = name
end

AnimatedTile = {}
AnimatedTile.__index = AnimatedTile

setmetatable(AnimatedTile, {
	__index = Tile,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

function AnimatedTile:_init(name, image, traverseable, animation_delay)
	Tile._init(self, name, image, traverseable)
	self.animation_delay = animation_delay
	self.animation = newAnimation(self.image,16,16,self.animation_delay,0)
	self.tile_type = 'animated'
	self.animated = true
	self.name = name
end

TeleTile = {}
TeleTile.__index = TeleTile

setmetatable(TeleTile, {
	__index = Tile,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

function TeleTile:_init(name, image, traverseable, target_index, target_x, target_y)
	Tile._init(self, name, image, traverseable)
	self.tile_type = 'tele'
	self.animated = false
	self.target_index = target_index
	self.target_x = target_x
	self.target_y = target_y
end

function TeleTile:teleport(map, player)
	map:setCurrentArea(self.target_index)
	player.x = self.target_x*tile_size
	player.y = self.target_y*tile_size
end

AnimatedTeleTile = {}
AnimatedTeleTile.__index = AnimatedTeleTile

setmetatable(AnimatedTeleTile, {
	__index = AnimatedTile,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self._init(...)
		return self
	end,
})

function AnimatedTeleTile:_init(name, image, traverseable, animation_delay, target_index, target_x, target_y)
	AnimatedTile._init(self, name, image, traverseable, animation_delay)
	self.tile_type = 'tele'
	self.target_index = target_index
	self.target_x = target_x
	self.target_y = target_y
end
