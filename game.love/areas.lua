--[[
Carlo Supina
www.github.com/cdsupina
cdsupina@gmail.com
]]

require 'map'
require 'area'
require 'tile'
require 'constants'
require 'object'
require 'area_helper'

-- DEFINITIONS OF TILES
grass_tile = Tile('grass',grass_tile_image,true)
metal_wall_tile = Tile('metal wall',metal_wall_tile_image,false)
brick_wall_tile = Tile('brick wall',brick_wall_tile_image,false)
horizontal_log_tile = Tile('horizontal log',horizontal_log_tile_image,false)
vertical_log_tile = Tile('vertical log',vertical_log_tile_image,false)
horizontal_log_left_tile = Tile('left end log',horizontal_log_left_tile_image,false)
horizontal_log_right_tile = Tile('right end log',horizontal_log_right_tile_image,false)
vertical_log_top_tile = Tile('top end log',vertical_log_top_tile_image,false)
vertical_log_bottom_tile = Tile('bottom end log',vertical_log_bottom_tile_image,false)
plank_floor_tile = Tile('plank floor',plank_floor_tile_image,true)
gravel_tile = Tile('gravel floor',gravel_tile_image,true)
water_tile = AnimatedTile('water',water_tile_image,false,1)

-- DEFINITIONS OF OBJECTS
downstairs_object = Object('downstairs', downstairs_object_image, true, function() print('Go downstairs?') end)
bed_top_object = Object('bed_top', bed_top_object_image, false, function() print('this is a bed top') end)
bed_bottom_object = Object('bed_bottom', bed_bottom_object_image, false, function() print('this is a bed bottom') end)


-- DEFINITIONS OF AREAS
starting_area = Area(grass_tile)
area1 = Area(grass_tile)
area2 = Area(grass_tile)
area3 = Area(grass_tile)
area4 = Area(grass_tile)

-- DEFINITION OF MAP
map = Map(starting_area)
map:addArea(area1)
map:addArea(area2)
map:addArea(area3)
map:addArea(area4)

-- STARTING AREA

-- area specific tiles

starting_area_teletiles = {}

-- two gravel tiles on left side
for i=1, 2 do
	starting_area_teletiles[i] = TeleTile('tele_gravel',gravel_tile_image,true, 2,38,i+13)
	starting_area:setTile(1,i+14,starting_area_teletiles[i])
end

-- two gravel tiles on right side
for i=1, 2 do
	starting_area_teletiles[i+2] = TeleTile('tele_gravel',gravel_tile_image,true, 3,1,i+13)
	starting_area:setTile(40,i+14,starting_area_teletiles[i+2])
end

-- two gravel tiles on top side
for i=1, 2 do
	starting_area_teletiles[i+4] = TeleTile('tele_gravel',gravel_tile_image,true,4,i+18,28)
	starting_area:setTile(i+19,1,starting_area_teletiles[i+4])
end

-- two gravel tiles on bottom side
for i=1, 2 do 
	starting_area_teletiles[i+6] = TeleTile('tele_gravel',gravel_tile_image,true,5,i+18,1)
	starting_area:setTile(i+19,30,starting_area_teletiles[i+6])
end

-- top and bottom brick walls 
for i=1, 14 do
	starting_area:setTile(1,i,brick_wall_tile)
	starting_area:setTile(1,31-i,brick_wall_tile)
	starting_area:setTile(40,i,brick_wall_tile)
	starting_area:setTile(40,31-i,brick_wall_tile)
end

-- left and right brick walls
for i=2, 19 do
	starting_area:setTile(i,1,brick_wall_tile)
	starting_area:setTile(41-i,1,brick_wall_tile)
	starting_area:setTile(i,30,brick_wall_tile)
	starting_area:setTile(41-i,30,brick_wall_tile)
end

-- arrempt to set a wall from the area_helper function (currently not working)
wall(staring_area, brick_wall_tile, 2, 'up', 5, 15)

-- log cabin frame
starting_area:setTile(3,4,horizontal_log_left_tile)
for i=4, 10 do
	starting_area:setTile(i,4,horizontal_log_tile)
end
starting_area:setTile(11,4,horizontal_log_right_tile)

starting_area:setTile(3,9,horizontal_log_left_tile)
for i=4, 7 do
	starting_area:setTile(i,9,horizontal_log_tile)
end
starting_area:setTile(10,9,horizontal_log_tile)
starting_area:setTile(11,9,horizontal_log_right_tile)

starting_area:setTile(4,3,vertical_log_top_tile)
for i=5, 8 do
	starting_area:setTile(4,i,vertical_log_tile)
end
starting_area:setTile(4,10,vertical_log_bottom_tile)

starting_area:setTile(10,3,vertical_log_top_tile)
for i=5, 8 do
	starting_area:setTile(10,i,vertical_log_tile)
end
starting_area:setTile(10,10,vertical_log_bottom_tile)

-- wooden plank floor of the cabin
for i=5, 8 do
	for j=5, 9 do
		starting_area:setTile(j,i,plank_floor_tile)
	end
end
 
starting_area:setTile(8,9,plank_floor_tile)
starting_area:setTile(9,9,plank_floor_tile)

-- left to right gravel path
for i=15, 16 do
	for j=2, 39 do
		starting_area:setTile(j,i,gravel_tile)
	end
end

-- top to bottom gravel path
for x=20, 21 do
	for y=2, 29 do
		starting_area:setTile(x,y,gravel_tile)
	end
end

-- objects in the log cabin
starting_area:setObject(9,5,downstairs_object)
starting_area:setObject(5,5,bed_top_object)
starting_area:setObject(5,6,bed_bottom_object)

-- water tiles in the top right corner
for x=30, 39 do
  for y=2, 5 do
    starting_area:setTile(x,y,water_tile)
  end
end

--for testing interacting with objects
starting_area.closest_object = downstairs

--AREA 1
area1_teletiles = {}
for i=1, 2 do
	area1_teletiles[i] = TeleTile('tele_gravel',gravel_tile_image,true, 1,1,i+13)
	area1:setTile(40,i+14,area1_teletiles[i])
end

-- AREA 2
area2_teletiles = {}
for i=1, 2 do
	area2_teletiles[i] = TeleTile('tele_gravel',gravel_tile_image,true, 1,38,i+13)
	area2:setTile(1,i+14,area2_teletiles[i])
end

-- AREA 3
area3_teletiles = {}
for i=1, 2 do
	area3_teletiles[i] = TeleTile('tele_gravel',gravel_tile_image,true,1,18+i,1)
	area3:setTile(19+i, 30, area3_teletiles[i])
end

-- AREA 4
area4_teletiles = {}
for i=1, 2 do
	area4_teletiles[i] = TeleTile('tele_gravel',gravel_tile_image,true,1,18+i,28)
	area4:setTile(19+i,1,area4_teletiles[i])
end
