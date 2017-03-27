--[[
Carlo Supina
www.github.com/cdsupina
cdsupina@gmail.com
]]

require 'player'
require 'areas'
require 'constants'

-- called once at the beginning of the program
function love.load()
	love.window.setMode(window_width,window_height)
	love.window.setTitle(window_name)
	p = Player(tile_size,tile_size,2,map)
end

-- called every tick
function love.update(dt)
	p:behave()
	map.current_area:update(dt, p)
end

-- checks for keys released
function love.keyreleased(key)
  if key == 'e' then
    print(map.current_area.closest_object:examine())
  end
end

-- called every tick
function love.draw()
	map.current_area:draw()	
	p:draw()
	love.graphics.print("FPS: " .. love.timer.getFPS(),0,0)
end
