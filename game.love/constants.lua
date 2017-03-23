--window properties
window_width = 640
window_height = 480
window_name = 'RPG'
--tile properties
tile_size = 16
tile_rows = 30
tile_cols = 40

--image objects
tile_directory = 'assets/images/tiles/'
grass_tile_path = love.graphics.newImage(tile_directory .. 'grass.png')
metal_wall_tile_path = love.graphics.newImage(tile_directory .. 'wall.png')
brick_wall_tile_path = love.graphics.newImage(tile_directory .. 'brick_wall.png')
horizontal_log_tile_path = love.graphics.newImage(tile_directory .. 'horizontal_log.png')
vertical_log_tile_path = love.graphics.newImage(tile_directory .. 'vertical_log.png')
horizontal_log_left_tile_path = love.graphics.newImage(tile_directory .. 'horizontal_log_left.png')
horizontal_log_right_tile_path = love.graphics.newImage(tile_directory .. 'horizontal_log_right.png')
vertical_log_top_tile_path = love.graphics.newImage(tile_directory .. 'vertical_log_top.png')
vertical_log_bottom_tile_path = love.graphics.newImage(tile_directory .. 'vertical_log_bottom.png')
plank_floor_tile_path = love.graphics.newImage(tile_directory .. 'plank_floor.png')
gravel_tile_path = love.graphics.newImage(tile_directory .. 'gravel.png')
downstairs_tile_path = love.graphics.newImage(tile_directory .. 'downstairs.png')
bed_top_tile_path = love.graphics.newImage(tile_directory .. 'bed_top.png')
bed_bottom_tile_path = love.graphics.newImage(tile_directory .. 'bed_bottom.png')
water_tile_path = love.graphics.newImage(tile_directory .. 'water.png')
