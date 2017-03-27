--[[
Carlo Supina
www.github.com/cdsupina
cdsupina@gmail.com
]]

require 'constants'

Player = {}
Player.__index = Player

setmetatable(Player, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

-- Creates new player
-- @param x The initial x position of the player
-- @param y The initial y position of the player
-- @param speed The initial speed of the player
-- @param map The map that the player will occupy
function Player:_init(x, y, speed, map)
	self.x = x
	self.y = y
	self.speed = speed
	self.map = map
  self.direction = 'down'
end

-- Returns a string of information about the player
-- @return The string of information about the player
function Player:toString()
	return "x: " ..  tostring(self.x) .. " y: " .. tostring(self.y) .. "\n" .. "speed: " .. tostring(self.speed)
end

-- Perform fire function
function Player:fire()
	print("fire")
end

-- Checks if the either of two tiles is a teleporting tile and teleports the player if necessary
-- @param tile1 The first tile to check
-- @param tile2 The second tile to check
function Player:teleport(tile1, tile2)
  if tile1.teleporting then
    tile1:teleport(self.map,self)
  elseif tile2.teleporting then
    tile2:teleport(self.map,self)
  end
end

-- Move the player to the right if the path is traverseable
function Player:moveRight()
  self.direction = 'right'
	top_corner_tile = self.map.current_area:getTile(self.x+(tile_size*2),self.y+1)
	bottom_corner_tile = self.map.current_area:getTile(self.x+(tile_size*2),self.y+(tile_size-1))

	if self.x % tile_size == 0 then
		if top_corner_tile.traverseable and bottom_corner_tile.traverseable then

			self:teleport(top_corner_tile, bottom_corner_tile)
			self.x = self.x + self.speed
		end
	else
		self.x = self.x + self.speed
	end
end

-- Move the player to the left if the path is traverseable
function Player:moveLeft()
  self.direction = 'left'
	top_corner_tile = self.map.current_area:getTile(self.x,self.y+1)
	bottom_corner_tile = self.map.current_area:getTile(self.x,self.y+(tile_size-1))

	if self.x % tile_size == 0 then
		if top_corner_tile.traverseable and bottom_corner_tile.traverseable then
			
      self:teleport(top_corner_tile, bottom_corner_tile)
			self.x = self.x - self.speed
		end
	else
		self.x = self.x - self.speed
	end
end

-- Move the player up if the path is traverseable
function Player:moveUp()
  self.direction = 'up'
	left_corner_tile = self.map.current_area:getTile(self.x+1,self.y)
	right_corner_tile = self.map.current_area:getTile(self.x+(tile_size-1),self.y)

	if self.y % (tile_size) == 0 then
		if left_corner_tile.traverseable and right_corner_tile.traverseable then
			
      self:teleport(left_corner_tile, right_corner_tile)
			self.y = self.y - self.speed
		end
	else
		self.y = self.y - self.speed
	end
end

-- Move the player down if the path is traverseable
function Player:moveDown()
  self.direction = 'down'
	left_corner_tile = self.map.current_area:getTile(self.x+1,self.y+(tile_size*2))
	right_corner_tile = self.map.current_area:getTile(self.x+(tile_size-1),self.y+(tile_size*2))

	if self.y % tile_size == 0 then
		if left_corner_tile.traverseable and right_corner_tile.traverseable then

      self:teleport(left_corner_tile, right_corner_tile)
			self.y = self.y + self.speed
		end
	else
		self.y = self.y + self.speed
	end
end

-- Call all functions that should be called every tick
function Player:behave()
	if love.keyboard.isDown("a") then
    self:moveLeft()
  elseif love.keyboard.isDown("d") then
    self:moveRight()

  end 

  if love.keyboard.isDown("w") then
    self:moveUp()
  elseif love.keyboard.isDown("s") then
    self:moveDown()
  end

	if love.keyboard.isDown("space") then
		self:fire()
	end
end

-- Draw the player 
function Player:draw()
	love.graphics.rectangle("fill",self.x,self.y,tile_size,tile_size)
end

