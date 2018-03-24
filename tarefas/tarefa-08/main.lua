-------------------- tarefa-06
-- Nome da variável: obstaculos 
-- Tipo de dado: array
obstaculos = {}


--------------------- tarefa-06
-- Nome da variável: player 
-- Tipo de dado: registro 
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
	fundo = love.graphics.newImage('fundo.jpg')	
   player.img = love.graphics.newImage("cat1.png")   
   font = love.graphics.newFont(30)
	
end

-----------------------------Tarefa-08 
--Cria o novo objeto retangular


function new(x, y, v)
  local me; me = {

	size = function()
		return 10,10
	end,
	
    move = function(dx, dy)
      x = x + dx
      y = y + dy
      return x, y
    end,

    get = function()
      return x, y
    end,

    -- Tarefa 08 - Co-rotina que faz o retangulo se movimentar de forma retangular
    co = coroutine.create(function(dt)
      while true do
        for i = 1, 50 do
          me.move(0, 2*v*dt)
          dt = coroutine.yield()
        end

        for i = 1, 50 do
          me.move(-v*dt, 0)
          dt = coroutine.yield()
        end

        for i = 1, 50 do
          me.move(0, -v/2*dt)
          dt = coroutine.yield()
        end

        for i = 1, 50 do
          me.move(v*dt, 0)
          dt = coroutine.yield()
        end
      end
    end),    
   
  }
  return me
end



local o1 = new(100, 100, 100)

function love.update(dt)
   -- Sair do jogo --


	--------------------- tarefa-06
	-- Nome da variável: love.keyboard 
	-- Tipo de dado: enumeração

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
			obstTemp = love.math.random(500,700)
 
			newObstacle= { x = 650, y = 650, width = 25, height = 50, counted = false}
			table.insert(obstaculos, newObstacle)			

			------------------ tarefa-07
			-- Coleção dinâmica de objetos
			-- O array obstaculos é uma varíavel global que ira conter todos os objetos da coleção.
			-- Escopo:global, ou seja, pode ser acessado em qualquer parte do programa
			-- Tempo de vida:Essa varíavel está desde o início da primeira partida do jogo,
			-- e todos os seus objetos serão apagados a cada vez que for iniciado uma nova partida.
			-- Alocação: No ínicio do jogo
			-- Desalocação:No encerramento do jogo
					

			--------------------- tarefa-06
			-- Nome da variável: table 
			-- Tipo de dado: dicionário

		end

			
		
		
		for i, obstacle in ipairs(obstaculos) do
			obstacle.x = obstacle.x - 10
			
			if obstacle.x < 0 then
					table.remove(obstacle, i)
			end
				------------------ tarefa-07
				--Parte do código responsável pela remoção dos objetos da coleção.
				--Cada objeto recebe um temporizador random com valor entre 200 e 700.
				-- Para cada obstaculo pulado a variável cont acrescenta mais 1.
				-- Ao colidir com o obstaculo, o obstaculo é removido do array e do jogo.
			
			if obstacle.counted == false and obstacle.x < player.x then
				obstacle.counted = true
				cont = cont + 1
			
			end 
		end
 
		-- Colisões --
		for i, obstacle in ipairs(obstaculos) do
			if CheckCollision(player.x,player.y,player.img:getWidth(),player.img:getHeight(),obstacle.x,obstacle.y,obstacle.width,obstacle.height) then
				gameover = true				
					
				----------------- tarefa-07
				-- Parte do código que checa se o jogador colidiu com algum objeto da coleção.
				-- Caso a função CheckCollision retorne verdadeiro para algum elemento o jogo acaba.
			end
		end

		-- tarefa-8 - Colisão do player com o novo objeto o1 --
			o1x,o1y = o1.get()
			o1height,o1width = o1.size()
			if CheckCollision(player.x,player.y,player.img:getWidth(),player.img:getHeight(),o1x,o1y,o1width,o1height) then
				gameover = true			
			end
		
	end

	-----------------Tarefa-08 
	coroutine.resume(o1.co, dt)
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
 	
 	------------------------------Tarefa-08
 	--desenha o novo retangulo
 	local x,y = o1.get()
    love.graphics.rectangle('fill', x,y, 10,10)

    -- Obstaculos ---
	for i, obstacle in ipairs(obstaculos) do		  
	  	love.graphics.rectangle('fill', obstacle.x, obstacle.y, obstacle.width, obstacle.height);	  	
	end


end
