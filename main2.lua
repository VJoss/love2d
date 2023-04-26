package.path = package.path..";C:/Users/Joss/Desktop/GAMEDEV/?.lua"

function menuMusique()
  bgm = love.audio.newSource("bgm_menu.mp3", "stream")
  love.audio.play(bgm)
end
----------------------------------------------- Fonction menu ------------------------------------------------
function startGame()

  require 'main3'
  
  
 
  
end

function showOptions()
 
end

function quitGame()
  love.event.quit()
end


local menuItems = {
  {text = "New game", action = startGame},
  {text = "Options", action = showOptions},
  {text = "Quitter", action = quitGame}
}

function drawMenu()
  for i, item in ipairs(menuItems) do
    love.graphics.print(item.text, 250, 150 + i * 70)
    
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  
  for i, item in ipairs(menuItems) do
    if x > 250 and x < 450 and y > 150 + i * 70 and y < 200 + i * 70 then
      item.action()
    end
  end
end
function love.load()
 
  
  -- Police d'écriture --- 
  font = love.graphics.newFont ("ThaleahFat.ttf", 80, normal)
  font2 = love.graphics.newFont ("ThaleahFat.ttf", 150, normal)
    -- Charger l'image de fond
    background = love.graphics.newImage("background3.jpg")
    
    -- Initialiser la position de l'image de fond
    backgroundX1 = 0
    backgroundX2 = -background:getWidth()
    
    -- Initialiser la vitesse de défilement de l'image de fond
    backgroundSpeed = 100
    menuMusique()
    end
function love.update(dt)

   -- Mettre à jour la position de l'image de fond en fonction de la vitesse de défilement
    backgroundX1 = backgroundX1 + backgroundSpeed * dt
    backgroundX2 = backgroundX2 + backgroundSpeed * dt
    
    -- Si la première instance de l'image de fond sort de l'écran, la ramener en haut
    if backgroundX1 > love.graphics.getWidth() then
        backgroundX1 = backgroundX2 - background:getWidth()
    end
    
    -- Si la deuxième instance de l'image de fond sort de l'écran, la ramener en haut
    if backgroundX2 > love.graphics.getWidth() then
        backgroundX2 = backgroundX1 - background:getWidth()
    end
 
end

function love.draw()
  -- Dessiner l'image de fond en deux instances pour remplir l'écran
    love.graphics.draw(background, backgroundX1, 0)
    love.graphics.draw(background, backgroundX2, 0)
    love.graphics.setFont(font)
  drawMenu()
  love.graphics.setFont(font2)
  love.graphics.print("PONG", 260, 0)
  
  end
-----------------------------------------------------------------------------------------------------------