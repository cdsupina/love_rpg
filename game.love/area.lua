require 'constants'


Area = {}
Area.__index = Area

setmetatable(Area, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

--Area tables contain a multidimensional table of tiles
--to initialize the player must enter a default tile as a parameter
--the entire area will be filled with this tile
function Area:_init(ground)
	self.rows = tile_rows
	self.cols = tile_cols
	self.ground = ground
	self.tiles = self:initTiles()
	self.objects = self:initObjects()
  self.closest_object = 'nothing'
end

--fills every tile in the area with the default 'ground' tile
function Area:initTiles()
	result = {}
	for x=1, self.cols do
		result[x] = {}
		for y=1, self.rows do
			result[x][y] = self.ground
		end
	end

	return result
end

--fills every objects space with a blank table
function Area:initObjects()
	result = {}
	for x=1, self.cols do
		result[x] = {}
		for y=1, self.rows do
			result[x][y] = nil
		end
	end

  return result
end

--sets the tile at the tile coordinate to the specified tile
function Area:setTile(x, y, tile)
	self.tiles[x][y] = tile
end

function Area:setObject(x,y, object)
  self.objects[x][y] = object
end

--updates all tiles containing animations
function Area:update(dt, player)
	water_tile.animation:update(dt)

  --player_top,_bottom,_left and _right are all coordinates of the subhitbox of the player that will be the basis of the interacting range
  player_top = {}
  player_top.x = player.x + (tile_size/2)
  player_top.y = player.y + (tile_size/4)

  player_bottom = {}
  player_bottom.x = player.x + (tile_size/2)
  player_bottom.y = player.y + ((tile_size*3)/4)

  player_left = {}
  player_left.x = player.x + (tile_size/4)
  player_left.y = player.y + (tile_size/2)

  player_right = {}
  player_right.x = player.x + ((tile_size*3)/4) 
  player_right.y = player.y + (tile_size/2)

  --print('player_top: '..player_top.x..','..player_top.y..' player_bottom: '..player_bottom.x..','..player_bottom.y..
  --' player_left: '..player_left.x..','..player_right.y..' player_right: '..player_right.x..','..player_right.y)
end

--draw all of the tiles in the area
function Area:drawTiles()
	for x=0, self.cols-1 do
		for y=0, self.rows-1 do
			if not self.tiles[x+1][y+1].animated then
				love.graphics.draw(self.tiles[x+1][y+1].image,x*tile_size,y*tile_size)
			elseif self.tiles[x+1][y+1].animated then
				self.tiles[x+1][y+1].animation:draw(x*tile_size,y*tile_size)
			end
		end
	end
end

--draw all of the objects in the area
function Area:drawObjects()
  for x=0, self.cols-1 do
    for y=0, self.rows-1 do
      if self.objects[x+1][y+1] ~= nil then
        love.graphics.draw(self.objects[x+1][y+1].image,x*tile_size,y*tile_size)
      end
    end
  end
end

--all of the tiles and objects in the area
function Area:draw()
  self:drawTiles()
  self:drawObjects()
end

--takes in a coordinate on the window and returns appropriate tile 
--by dividing the coordinate by the tile width and rounding up
function Area:getTile(x,y)
	return self.tiles[math.ceil(x/tile_size)][math.ceil(y/tile_size)]
end
