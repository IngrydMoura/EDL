
player = {}
cat2={}

tile = {}
for i=1,29 do 
    tile[i] = love.graphics.newImage( "plat"..i..".png")   
end
 
  


 
function love.load()
    

	
  cat2.img = love.graphics.newImage('catGirl.png')
  cat2.x = 560
  cat2.y = 560
    
  player.img = love.graphics.newImage('cat1.png')
	player.x = 25
	player.y = love.graphics.getHeight() - 20
 
	player.speed = 500
 
    

    
end
 
function love.update(dt)


	if love.keyboard.isDown('d') then
		  player.img = love.graphics.newImage('cat1.png')
			player.x = player.x + (player.speed * dt)
      
      if player.x > love.graphics.getWidth()- 40 then
          player.x = love.graphics.getWidth() - 40
      end
      
      
  end
  if love.keyboard.isDown('s') then   
      player.img = love.graphics.newImage('cat4.png')
      player.y = player.y + (player.speed * dt)
     
      
      if player.y > love.graphics.getHeight() then
          player.y = love.graphics.getHeight() - 10
      end 
  end  
	if love.keyboard.isDown('a') then
		  player.img = love.graphics.newImage('cat3.png')
			player.x = player.x - (player.speed * dt)
      
      if player.x < 60 then
          player.x = 60
      end
      
      
  end
  if love.keyboard.isDown('w') then
    player.img = love.graphics.newImage('cat2.png')
    player.y = player.y -(player.speed * dt)
    
      if player.y < love.graphics.getHeight() - 500   then
          player.y = love.graphics.getHeight() - 500
      end 
  end


  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
    
    
for i=1,29 do     
if player.x + player.img:getWidth() > tile[i].x and player.y < player.img:getHeight() + tile[i].y then -- Prevents teleporting to the top of the platform
  
          player.x = tile[i].x - player.img:getWidth() - 1 

          player.x = tile[i].x + tile[i].y + 1 
end
end
    
 -- CheckCollision(player.x,player.y,player.img:getWidth(),player.img:getHeight(),tile.x,tile.y,tile.width,tile.height)
   
 
	 	
end


--[[
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
   for i, tile in ipairs(tile) do
      if x1==x2 and y1==y2 then
        x1 = x2 - w2
        y1 = y2 - h2
      end

   end 
         
end


]]
 
function love.draw()  	

    fundo = love.graphics.newImage("fundo.jpg")  
    love.graphics.draw(fundo,0,0) 
 
    --love.graphics.draw(platform.img, platform.x, platform.y, 800, 31)
    for i=1,29 do 
       love.graphics.draw(tile[i], 0, 0)
    end
    

    love.graphics.draw(cat2.img, cat2.x, cat2.y, 0, 1.5, 1.5, -25, 250)
    love.graphics.draw(player.img, player.x, player.y, 0, 1.5, 1.5, 15, 50)
    

end