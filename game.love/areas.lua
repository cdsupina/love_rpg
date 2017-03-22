require 'area'
require 'tile'
require 'constants'

grass_tile = Tile('grass',grass_tile_path,true)
metal_wall_tile = Tile('metal wall',metal_wall_tile_path,false)
brick_wall_tile = Tile('brick wall',brick_wall_tile_path,false)
horizontal_log_tile = Tile('horizontal log',horizontal_log_tile_path,false)
vertical_log_tile = Tile('vertical log',vertical_log_tile_path,false)
horizontal_log_left_tile = Tile('left end log',horizontal_log_left_tile_path,false)
horizontal_log_right_tile = Tile('right end log',horizontal_log_right_tile_path,false)
vertical_log_top_tile = Tile('top end log',vertical_log_top_tile_path,false)
vertical_log_bottom_tile = Tile('bottom end log',vertical_log_bottom_tile_path,false)
plank_floor_tile = Tile('plank floor',plank_floor_tile_path,true)
gravel_tile = Tile('gravel floor',gravel_tile_path,true)
downstairs_tile = Tile('downstairs',downstairs_tile_path,true)
bed_top_tile = Tile('top bed',bed_top_tile_path,false)
bed_bottom_tile = Tile('bottom bed',bed_bottom_tile_path,false)
water_tile = AnimatedTile('water',water_tile_path,false,1)


starting_area = Area(grass_tile)
area1 = Area(grass_tile)
area2 = Area(grass_tile)

--starting area

--area specific tiles
starting_area_teletiles = {}
for i=1, 2 do
	starting_area_teletiles[i] = TeleTile('tele_gravel',gravel_tile_path,true, 2,38,i+13)
	starting_area:setTile(1,i+14,starting_area_teletiles[i])
end

for i=1, 2 do
	starting_area_teletiles[i+2] = TeleTile('tele_gravel',gravel_tile_path,true, 3,1,i+13)
	starting_area:setTile(40,i+14,starting_area_teletiles[i+2])
end

for i=1, 14 do
	starting_area:setTile(1,i,brick_wall_tile)
	starting_area:setTile(1,31-i,brick_wall_tile)
	starting_area:setTile(40,i,brick_wall_tile)
	starting_area:setTile(40,31-i,brick_wall_tile)
end

for i=2, 19 do
	starting_area:setTile(i,1,brick_wall_tile)
	starting_area:setTile(41-i,1,brick_wall_tile)
	starting_area:setTile(i,30,brick_wall_tile)
	starting_area:setTile(41-i,30,brick_wall_tile)
end

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

for i=5, 8 do
	for j=5, 9 do
		starting_area:setTile(j,i,plank_floor_tile)
	end
end
starting_area:setTile(8,9,plank_floor_tile)
starting_area:setTile(9,9,plank_floor_tile)

for i=15, 16 do
	for j=2, 39 do
		starting_area:setTile(j,i,gravel_tile)
	end
end

for x=20, 21 do
	for y=2, 29 do
		starting_area:setTile(x,y,gravel_tile)
	end
end

starting_area:setTile(9,5,downstairs_tile)
starting_area:setTile(5,5,bed_top_tile)
starting_area:setTile(5,6,bed_bottom_tile)

for x=30, 39 do
  for y=2, 5 do
    starting_area:setTile(x,y,water_tile)
  end
end

--area 1
area1_teletiles = {}
for i=1, 2 do
	area1_teletiles[i] = TeleTile('tele_gravel',gravel_tile_path,true, 1,1,i+13)
	area1:setTile(40,i+14,area1_teletiles[i])
end

--area 2
area2_teletiles = {}
for i=1, 2 do
	area2_teletiles[i] = TeleTile('tele_gravel',gravel_tile_path,true, 1,38,i+13)
	area2:setTile(1,i+14,area2_teletiles[i])
end

