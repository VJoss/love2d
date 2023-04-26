pad = {}
pad.x = 20
pad.y = love.graphics.getHeight() / 2 - 40
pad.largeur = 20
pad.hauteur = 80

pad2 = {}
pad2.x = love.graphics.getWidth() - 40
pad2.y = love.graphics.getHeight() / 2 -40
pad2.largeur = 20
pad2.hauteur = 80

balle = {}
balle.x = 400
balle.y = 300
balle.largeur = 20
balle.hauteur = 20
balle.vitesse_x = 4
balle.vitesse_y = 4
scorePlayer_1 = 0
scorePlayer_2 = 0



function player_1_Point()
    scorePlayer_1 = scorePlayer_1 + 1
  end
  function player_2_Point()
    scorePlayer_2 = scorePlayer_2 + 1
    end
  
    function Centreballe()
  balle.x = love.graphics.getWidth() / 2
  balle.x = balle.x - balle.largeur / 2
  
  balle.y = love.graphics.getHeight() / 2
  balle.y = balle.y - balle.hauteur / 2
  
end

  

function love.load()
 bg = love.graphics.newImage("Background.png")
 
 Centreballe()
 
end

function love.update(dt)
  
    if love.keyboard.isDown("down") and pad.y < love.graphics.getHeight() - pad.hauteur then
    pad.y = pad.y + 2
  end
  if love.keyboard.isDown("up") and pad.y > 0 then
    pad.y = pad.y - 2
  end
  if love.keyboard.isDown("s") and pad2.y < love.graphics.getHeight() - pad2.hauteur then
    pad2.y = pad2.y + 2
  end
  if love.keyboard.isDown("z") and pad2.y > 0 then
    pad2.y = pad2.y - 2
    end
  
  balle.x = balle.x + balle.vitesse_x
  balle.y = balle.y + balle.vitesse_y
  
  if balle.x < 0 then
    Centreballe()
    player_1_Point()
    balle.vitesse_x = 2
    balle.vitesse_y = 2
  end
 
  if balle.y < 0 then
    balle.vitesse_y = balle.vitesse_y * -1
  end
  if balle.x > love.graphics.getWidth() then
    Centreballe()
    player_2_Point()
    balle.vitesse_x = - 2
    balle.vitesse_y = - 2
  end
  if balle.y > love.graphics.getHeight() - balle.hauteur then
    balle.vitesse_y = balle.vitesse_y * -1
  end
  
  if balle.x <= pad.x + pad.largeur then
    if balle.y + balle.hauteur > pad.y and balle.y < pad.y + pad.hauteur
    then
      balle.vitesse_x = balle.vitesse_x * -1
      end
    end
    if balle.x + balle.largeur >= pad2.x then
      if balle.y + balle.hauteur > pad2.y and balle.y < pad2.y + pad2.hauteur
      then
        balle.vitesse_x = balle.vitesse_x * -1
        end
      end
   
end

function love.draw()
  love.graphics.rectangle("fill", pad.x, pad.y, pad.largeur, pad.hauteur)
  love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.largeur, pad2.hauteur)
  love.graphics.rectangle("fill", balle.x, balle.y, balle.largeur, balle.hauteur)
  love.graphics.circle("line", 400, 300, 120) 
  love.graphics.print(scorePlayer_1, 370, 10)
  love.graphics.print(scorePlayer_2, 420, 10)
  love.graphics.draw(bg, 0, 0)
  
end
