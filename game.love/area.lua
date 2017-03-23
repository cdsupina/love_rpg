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

--sets the tile at the tile coordinate to the specified tile
function Area:setTile(x, y, tile)
	self.tiles[x][y] = tile
end

--updates all tiles containing animations
function Area:update(dt)
	water_tile.animation:update(dt)
end

--draws the appropriate tile image for the tile's location
--if the tile is animated the the animation is drawn instead
function Area:draw()
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

--takes in a coordinate on the window and returns appropriate tile 
--by dividing the coordinate by the tile width and rounding up
function Area:getTile(x,y)
	return self.tiles[math.ceil(x/tile_size)][math.ceil(y/tile_size)]
end
