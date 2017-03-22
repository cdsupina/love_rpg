require 'player'
require 'areas'
require 'map'
require 'constants'

function love.load()
	love.window.setMode(window_width,window_height)
	love.window.setTitle(window_name)
	map = Map(starting_area)
	map:addArea(area1)
	map:addArea(area2)
	p = Player(tile_size,tile_size,2,map)
end

function love.update(dt)
	p:behave(map)
	map.current_area:update(dt)
end

function love.draw()
	map.current_area:draw()	
	p:draw()
	love.graphics.print("FPS: " .. love.timer.getFPS(),0,0)
end
