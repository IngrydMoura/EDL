platform = {}
player = {}
function love.load()

       --Largura e altura da plataforma--
    platform.width = love.graphics.getWidth()    
    platform.height = love.graphics.getHeight()  
 
    --Coordenadas da Plataforma--
    platform.x = 0                               
    platform.y = 500            

    player.x = love.graphics.getWidth()/2   
    player.y = love.graphics.getHeight()/2  

    player.img = love.graphics.newImage('sonic2.png')
    
end
 
function love.update(dt)
 
end
 
function love.draw()

    love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 50,-171)

    love.graphics.setBackgroundColor(56,176,222)      
          
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
    love.graphics.setColor(0, 153, 51) 
    
    
    
    
end

