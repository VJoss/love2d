

function menuMusique()
  bgm = love.audio.newSource("bgm_menu.mp3", "stream")
  love.audio.play(bgm)
end
function menuSelection()
selection = love.audio.newSource("Blip_Select2.wav", "static")
   love.audio.play(selection)
 end
 function volume()
  volume = love.audio.setVolume( 0.05)
  end
----------------------------------------------- Fonction menu ------------------------------------------------
_menu = {}
_menu.x = 180
_menu.y = 190
_menu.choix = {}
_menu.choix[1] = "New Game"
_menu.choix[2] = "Options"
_menu.choix[3] = "Quit"
_menu.selection = 1



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
    volume()
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
    
    ---MENU---
    local posY = _menu.y
    local hauteurLigne = font:getHeight("X")
    ---CHOIX---
    local n
    local marque = ""
    love.graphics.setFont(font)
    for n=1,#_menu.choix do
      if _menu.selection == n then
        marque = ">"
      else
        marque = "   "
        end
      love.graphics.print(marque.." ".._menu.choix[n],_menu.x,posY)
      posY = posY + hauteurLigne
     end 
  love.graphics.setFont(font2)
  ---TIRE---
  love.graphics.print("PONG", 260, 0)
  ---TOUCHES---
  function love.keypressed(touche)
    if touche == "down" then
      if _menu.selection < #_menu.choix then
        _menu.selection = _menu.selection +1
        menuSelection()
      end
    end
    if touche == "up" then
      if _menu.selection > 1 then
        _menu.selection = _menu.selection -1
        menuSelection()
      end
    end
    if touche == "return" then
      if _menu.selection == 1 then
        startGame()
     end
   end
   if touche == "return" then
     if _menu.selection == 2 then
       options()
     end
     end
   if touche == "return" then
     if _menu.selection == 3 then
       quitGame()
     end
     end
  end
  function quitGame()
  love.event.quit()
  
end
  function startGame()
    
  end
  function options()
    
end
    end
  


--------------------------------------------------------------------------------------------------------