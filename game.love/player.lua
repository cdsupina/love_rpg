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

--initialization function
function Player:_init(x, y, speed, map)
	self.x = x
	self.y = y
	self.speed = speed
	self.map = map
end

--tostring function automatically create reference to self
function Player:toString()
	return "x: " ..  tostring(self.x) .. " y: " .. tostring(self.y) .. "\n" .. "speed: " .. tostring(self.speed)
end

--fire function
function Player:fire()
	print("fire")
end

--move functions
function Player:moveRight(area)
	top_corner_tile = area:getTile(self.x+(tile_size*2),self.y+1)
	bottom_corner_tile = area:getTile(self.x+(tile_size*2),self.y+(tile_size-1))

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

function Player:moveLeft(area)
	top_corner_tile = area:getTile(self.x,self.y+1)
	bottom_corner_tile = area:getTile(self.x,self.y+(tile_size-1))

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

function Player:moveUp(area)
	left_corner_tile = area:getTile(self.x+1,self.y)
	right_corner_tile = area:getTile(self.x+(tile_size-1),self.y)

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

function Player:moveDown(area)
	left_corner_tile = area:getTile(self.x+1,self.y+(tile_size*2))
	right_corner_tile = area:getTile(self.x+(tile_size-1),self.y+(tile_size*2))

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

--behave functions, functions that should be called every tick
function Player:behave(map)
	if love.keyboard.isDown("a") then
    self:moveLeft(map.current_area)
  elseif love.keyboard.isDown("d") then
    self:moveRight(map.current_area)
  end 

  if love.keyboard.isDown("w") then
    self:moveUp(map.current_area)
  elseif love.keyboard.isDown("s") then
    self:moveDown(map.current_area)
  end

	if love.keyboard.isDown("space") then
		self:fire(map)
	end
end

--draw function for the player
function Player:draw()
	love.graphics.rectangle("fill",self.x,self.y,tile_size,tile_size)
end

