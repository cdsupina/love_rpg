require 'player'
require 'areas'
require 'constants'
require 'object'

function love.load()
	love.window.setMode(window_width,window_height)
	love.window.setTitle(window_name)
	p = Player(tile_size,tile_size,2,map)
end

function love.update(dt)
	p:behave(map)
	map.current_area:update(dt, p)
end

function love.keyreleased(key)
  if key == 'e' then
    print(map.current_area.closest_object:examine())
  end
end

function love.draw()
	map.current_area:draw()	
	p:draw()
	love.graphics.print("FPS: " .. love.timer.getFPS(),0,0)
end
