function wall(area, tile, length, direction, x, y)
  if direction == 'up' then
    for i=y, length do
      area:setTile()
    end
  end
end
