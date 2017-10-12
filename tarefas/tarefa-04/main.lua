
obstaculos = {}
player = { 
	x = 100, 
	y = 640,
	jump = false, 
	accel = aceleracao, 
	
}



obstTemp = 10 
gravity = 100
aceleracao = 16
gravid = 200 
cont = 0
gameover = false


function love.load()
   fundo = love.graphics.newImage("fundo.jpg")
   player.img = love.graphics.newImage("cat1.png")  
   font = love.graphics.newFont(40)

end
 
function love.update(dt)
   -- Sair do jogo --
   if love.keyboard.isDown('escape') then
	love.event.push('quit')
   end   
 
	
	if gameover == false then
		--Movimentação --
		if love.keyboard.isDown('space') and player.jump == false then
			player.jump = true
		end
 
		
		if player.jump and player.accel > 0 then
			player.y = player.y - player.accel
			player.accel = player.accel - 1
		end
 
		
		if player.y < 640 then
			player.y = player.y + gravity*dt;
			gravity = gravity + 10;
		end
 
		if player.y > 640 then 
			player.y = 640
		end
 
		if player.y == 640 then
			player.jump = false
			player.accel = aceleracao
			gravity = gravid
		end
 
		
		obstTemp = obstTemp - 10
		if obstTemp <= 0 then
			obstTemp = love.math.random(200,700)
 
			newObstacle= { x = 650, y = 650, width = 25, height = 50, counted = false}
			table.insert(obstaculos, newObstacle)
		end
		
		
		for i, obstacle in ipairs(obstaculos) do
			obstacle.x = obstacle.x - 10
			
			if obstacle.x < 0 then
				table.remove(obstacle, i)
			end
 
			
			if obstacle.counted == false and obstacle.x < player.x then
				obstacle.counted = true
				cont = cont + 1
				
			end
		end
 
		-- Colisões --
		for i, obstacle in ipairs(obstaculos) do
			if CheckCollision(player.x,player.y,player.img:getWidth(),player.img:getHeight(),obstacle.x,obstacle.y,obstacle.width,obstacle.height) then
				gameover = true
				
			end
		end
	end
end


function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
 
function love.draw()
	
	--fundo--
	love.graphics.draw(fundo,0,0)

	--player
    love.graphics.draw(player.img, player.x, player.y,0,1.8,1.8,0)
 
    
    --Fonte do Contador --
    love.graphics.setFont(font)
   	love.graphics.print(cont, 400, 300)	
 
 	-- Texto Game Over --
   	if (gameover) then
   		love.graphics.setColor(94,117,113)
   		love.graphics.print("GAME OVER", 300, 100)	
   	end
 
    -- Obstaculos ---
	for i, obstacle in ipairs(obstaculos) do	  
	  love.graphics.rectangle('fill', obstacle.x, obstacle.y, obstacle.width, obstacle.height);
	end

end