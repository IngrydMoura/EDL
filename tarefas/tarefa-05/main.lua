
obstaculos = {}
player = { 
	x = 100, 
	y = 640,
	jump = false, 
	accel = aceleracao, 
	
}

---------------- TAREFA-05
-- Nome: variável "x" e "y"
-- Propriedade: valor
-- Binding time: compilação
-- Explicação: as coordenadas do player são amarradas em tempo de compilação. 
-- A posição inicial ja é dada pelo programador, logo depois da compilação seu valor é setado no mesmo instante.
-- Porém, a variável y sofre mudanças no seu valor durante a execução do jogo.

---------------------------
obstTemp = 10 
gravity = 100
aceleracao = 16
gravid = 200 
cont = 0
gameover = false


---------------- TAREFA-05

--Nome: variável "gravity"
--Propriedade: valor
--Binding Time: compilação
--Explicação: seu valor é dado pelo programador porém durante a execução seu valor é alterado de acordo com as instruções dadas.

------------------------------

function love.load()
   fundo = love.graphics.newImage("fundo.jpg")
   player.img = love.graphics.newImage("cat1.png")  
   font = love.graphics.newFont(40)

end
 
---------------- TAREFA-05

--Nome: variavel "fundo"
--Propriedade: endereço 
--Binding Time: execução
--Explicação: dado que "fundo" é uma variavel local de uma função, seu endereço só pode ser determinado em tempo de execução.

--------------------------------

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


----------------- TAREFA 05
-- Nome: variáveis "x1", "x2", "y1", "y2", "h1", "h2", "w1", e "w2"
-- Propriedade: endereço
-- Binding time: execução
-- Explicação: por serem coordenadas das imagens e serem variáveis locais, seu endereço é determinado em tempo de execução.



-- Nome: função "CheckColision()"
-- Propriedade: implementação da função
-- Binding time: design
-- Explicação: por ser uma função em lua, seu bind time é em tempo de design. 

----------------------------
 
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

----------------- TAREFA 05
-- Nome: variavel "gameover"
-- Propriedade: tamanho ocupado em memória por variável tipo boolean
-- Binding time: design
-- Explicação: por se tratar do tamanho de um tipo de variável, seu bind é feito no tempo de concepção da linguagem.
-------------------------