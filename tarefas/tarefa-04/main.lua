platform = {}
player = {}

tile = {}
for i=1,11 do 
    tile[i] = love.graphics.newImage( "plat1.png")   
end
 
   -- map variables
  --[[ map_w = 100
   map_h = 100
   map_x = 0
   map_y = 0
   map_offset_x = 0
   map_offset_y = 0
   map_display_w = 20
   map_display_h = 20
   tile_w = 70
   tile_h = 70
   map={
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 1, 0, 0, 1, 0, 1, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}, 
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
}

--[[


function draw_map()
   for y=1, map_display_h do
      for x=1, map_display_w do                                                         
         love.graphics.draw( 
            tile[map[y+map_y][x+map_x]]--, 
           --[[ (x*tile_w)+map_offset_x, 
            (y*tile_h)+map_offset_y)
      end
   end
end --]]


 
function love.load()
    

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()
 
	platform.x = 0
	platform.y = platform.height / 2
 
    
    player.img = love.graphics.newImage('cat1.png')
	player.x = 0
	player.y = 930
 
	player.speed = 500
    player.ground = player.y
 
    player.y_velocity = 0
 
    player.jump_height = -400
    player.gravity = -200

    
         
    platform.img = love.graphics.newImage('platform.png')

    
end
 
function love.update(dt)


	if love.keyboard.isDown('d') then
		if player.x < 705 then
            player.img = love.graphics.newImage('cat1.png')
			player.x = player.x + (player.speed * dt)
		end
    end
	if love.keyboard.isDown('a') then
		if player.x > 0 then 
            player.img = love.graphics.newImage('cat3.png')
			player.x = player.x - (player.speed * dt)
		end
    end
    if love.keyboard.isDown('space') then
            if player.y_velocity == 0 then
                player.img = love.graphics.newImage('cat2.png')
                player.y_velocity = player.jump_height                
            elseif player.y_velocity ~= 0 then  
                player.img = love.graphics.newImage('cat2.png')
                player.y = player.y + player.y_velocity * dt
                player.y_velocity = player.y_velocity - player.gravity * dt
            end
    end

    if player.y > player.ground then
        
        player.y_velocity = 0
        player.y = player.ground        
    end
    if player.x < 0 then
        player.x = 0
    end
    if player.x > love.graphics.getWidth() then
        player.x = love.graphics.getWidth() - 2
    end
    if player.y < 0 then
        player.y = 0
    end
    if player.y > love.graphics.getHeight() then
        player.y = love.graphics.getHeight() - 2
    end
    if love.keyboard.isDown('escape') then
    love.event.push('quit')
    end
     
    
    CheckCollision(player.x,player.y,player.img:getWidth(),player.img:getHeight(),tile.x,tile.y,tile.width,tile.height)
   
 
	 	
end



function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
   for i, tile in ipairs(tile) do
      if x1==x2 and y1==y2 then
        player.img = love.graphics.newImage('cat2.png')
      end
   end 
         
end



--[[function love.keypressed(key, unicode)
   if key == 'up' then
      map_y = map_y-1
      if map_y < 0 then map_y = 0; end
   end
   if key == 'down' then
      map_y = map_y+1
      if map_y > map_h-map_display_h then map_y = map_h-map_display_h; end
   end
 
   if key == 'left' then
      map_x = math.max(map_x-1, 0)
   end
   if key == 'right' then
      map_x = math.min(map_x+1, map_w-map_display_w)
   end
   if key == "escape" then
    love.event.push("quit")
  end
end--]]


 
function love.draw()  	

    fundo = love.graphics.newImage("fundo2.png")  
    love.graphics.draw(fundo,0,0) 
 
    love.graphics.draw(platform.img, platform.x, platform.y, 800, 31)
    
    love.graphics.draw(tile[1], -30, 100)
    love.graphics.draw(tile[2], 400, 400)
    love.graphics.draw(tile[3], 100, 200)

    love.graphics.draw(tile[4], 500, 300)
    love.graphics.draw(tile[5], 600, 460)

    love.graphics.draw(tile[6], 300, 150)
    love.graphics.draw(tile[7], 500, 100)
    love.graphics.draw(tile[8], 600, 100)

    love.graphics.draw(tile[9], 10, 400)
    love.graphics.draw(tile[10], 200, 480)
    love.graphics.draw(tile[11], -80, 300)

    love.graphics.draw(player.img, player.x, player.y, 0, 2, 2, 0, 30)

end