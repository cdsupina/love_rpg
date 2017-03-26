--[[
Carlo Supina
]]

require 'constants'

--table to represent class
Player = {}
Player.__index = Player

--set metafunction to automatically initialize the object
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

-- Move the player to the right
function Player:moveRight()
  self.direction = 'right'
	top_corner_tile = self.map.current_area:getTile(self.x+(tile_size*2),self.y+1)
	bottom_corner_tile = self.map.current_area:getTile(self.x+(tile_size*2),self.y+(tile_size-1))

	if self.x % tile_size == 0 then
		if top_corner_tile.traverseable and bottom_corner_tile.traverseable then
			
			--check if moving into a TeleTile in which case it will teleport to the specified area and location
			if top_corner_tile.tile_type == 'tele' then
				top_corner_tile:teleport(self.map,self)
			elseif bottom_corner_tile.tile_type == 'tele' then
				bottom_corner_tile:teleport(self.map,self)
			end

			self.x = self.x + self.speed
		end
	else
		self.x = self.x + self.speed
	end
end

-- Move the player to the left
function Player:moveLeft()
  self.direction = 'left'
	top_corner_tile = self.map.current_area:getTile(self.x,self.y+1)
	bottom_corner_tile = self.map.current_area:getTile(self.x,self.y+(tile_size-1))

	if self.x % tile_size == 0 then
		if top_corner_tile.traverseable and bottom_corner_tile.traverseable then
			
			--check if moving into a TeleTile in which case it will teleport to the specified area and location
			if top_corner_tile.tile_type == 'tele'then
				top_corner_tile:teleport(self.map,self)
			elseif bottom_corner_tile.tile_type == 'tele' then
				bottom_corner_tile:teleport(self.map,self)
			end

			self.x = self.x - self.speed
		end
	else
		self.x = self.x - self.speed
	end
end

-- Move the player up
function Player:moveUp()
  self.direction = 'up'
	left_corner_tile = self.map.current_area:getTile(self.x+1,self.y)
	right_corner_tile = self.map.current_area:getTile(self.x+(tile_size-1),self.y)

	if self.y % (tile_size) == 0 then
		if left_corner_tile.traverseable and right_corner_tile.traverseable then
			
			--check if moving into a TeleTile in which case it will teleport to the specified area and location
			if left_corner_tile.tile_type == 'tele' then
				left_corner_tile:teleport(self.map,self)
			elseif right_corner_tile.tile_type == 'tele' then
				right_corner_tile:teleport(self.map,self)
			end


			self.y = self.y - self.speed
		end
	else
		self.y = self.y - self.speed
	end
end

-- Move the player down
function Player:moveDown()
  self.direction = 'down'
	left_corner_tile = self.map.current_area:getTile(self.x+1,self.y+(tile_size*2))
	right_corner_tile = self.map.current_area:getTile(self.x+(tile_size-1),self.y+(tile_size*2))

	if self.y % tile_size == 0 then
		if left_corner_tile.traverseable and right_corner_tile.traverseable then

			--check if moving into a TeleTile in which case it will teleport to the specified area and location
			if left_corner_tile.tile_type == 'tele' then
				left_corner_tile:teleport(self.map,self)
			elseif right_corner_tile.tile_type == 'tele' then
				right_corner_tile:teleport(self.map,self)
			end

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

