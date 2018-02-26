
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
-- Explicação:  dado que "x" e "y" são variaveis globais de uma função, seu endereço só pode ser determinado em tempo de compilação.
---------------------------
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
-- Nome: variável "obstacle.x"
-- Propriedade: valor
-- Binding time: execução
-- Explicação: Esta variável tem seu valor definido pelo comando do usuario, ou seja de acordo com a interaçao usuário-computador.Logo, o valor é atribuído durante a execução do programa.

-- Nome: função "CheckColision()"
-- Propriedade: implementação
-- Binding time: compilação
-- Explicação: Esta função tem o mesmo nome sendo utilizado por todo o código e foi não foi criada dentro de nenhuma outra função.
-- Logo, seu bind time é em tempo de compilação pois sua implementação para a função "CheckColision()" ocorre quando o programa é compilado.

-- Nome: símbolo "+"
-- Propriedade: semântica
-- Binding time: design
-- Explicação: O operador "+" significa adição entre dois valores. É atribuida a uma variável a semantica da operação no bind time de design.
-- Pois o simbolo "+" possui a mesma semantica para "+" que é definida pela linguagem Lua enquanto ocorre o design.


-- Nome: variável "love.math.random"
-- Propriedade: valor
-- Binding time: design
-- Explicação: A variável "love.math.random" é da biblioteca de matemática do Lua, e é parecida com uma tabela
-- externa, com seus valores sendo definidos no bind time de design da biblioteca.

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
