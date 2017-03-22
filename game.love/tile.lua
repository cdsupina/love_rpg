require 'AnAL'

Tile = {}
Tile.__index = Tile

setmetatable(Tile, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

function Tile:_init(name ,image_path, traverseable)
	self.image = love.graphics.newImage(image_path)
	self.traverseable = traverseable
	self.tile_type = 'static'
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

function AnimatedTile:_init(name, image_path, traverseable, animation_delay)
	Tile._init(self, name, image_path, traverseable)
	self.animation_delay = animation_delay
	self.animation = newAnimation(self.image,16,16,self.animation_delay,0)
	self.tile_type = 'animated'
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

function TeleTile:_init(name, image_path, traverseable, target_index, target_x, target_y)
	Tile._init(self, name, image_path, traverseable)
	self.tile_type = 'tele'
	self.target_index = target_index
	self.target_x = target_x
	self.target_y = target_y
end

function TeleTile:teleport(map, player)
	map:setCurrentArea(self.target_index)
	player.x = self.target_x*16
	player.y = self.target_y*16
end
